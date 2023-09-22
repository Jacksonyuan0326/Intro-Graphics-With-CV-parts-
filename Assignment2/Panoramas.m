function panorama = Panoramas(num, useHarris)

    % Set up image datastore
    Picdir = string("Pic" + string(num));
    imageDir = fullfile(Picdir, '*.jpg');
    imageDatastore = imageDatastore(imageDir);

    % Display images to be stitched
    montage(imageDatastore.Files);

    % Read the first image and extract features
    I = readimage(imageDatastore, 1);
    grayImage = im2gray(I);
    [points, ~] = my_fast_detector(grayImage, 0.01, useHarris);
    [features, points] = extractFeatures(grayImage, points);

    % Set up transformations and image sizes
    numImages = numel(imageDatastore.Files);
    tforms(numImages) = projtform2d;
    imageSize = zeros(numImages, 2);

    % Iterate over remaining image pairs
    for n = 2:numImages
        % Store points and features for previous image
        pointsPrevious = points;
        featuresPrevious = features;

        % Read current image and extract features
        I = readimage(imageDatastore, n);
        grayImage = im2gray(I);
        [points, ~] = my_fast_detector(grayImage, 0.01, useHarris);
        [features, points] = extractFeatures(grayImage, points);

        % Match features and estimate transformation
        indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);
        matchedPoints = points(indexPairs(:, 1), :);
        matchedPointsPrev = pointsPrevious(indexPairs(:, 2), :);
        tforms(n) = estgeotform2d(matchedPoints, matchedPointsPrev, ...
            'rigid', 'Confidence', 99.9, 'MaxNumTrials', 4000, 'MaxDistance', 50);
        tforms(n).A = tforms(n-1).A * tforms(n).A;

        % Save image size
        imageSize(n, :) = size(grayImage);

        % Save feature matching result
        if useHarris
            filename = "S" + string(num) + "-fastRMatch.png";
        else
            filename = "S" + string(num) + "-fastMatch.png";
        end
        saveas(showMatchedFeatures(readimage(imageDatastore, n-1), grayImage, matchedPoints, matchedPointsPrev), filename, "png");
    end

    % Find center image and compute output limits
    [~, idx] = sort(mean(tforms.T(3, 1:2, :), 2));
    centerIdx = floor((numImages+1)/2);
    centerImageIdx = idx(centerIdx);
    Tinv = invert(tforms(centerImageIdx));
    for j = 1:numImages
        tforms(j).T = Tinv.T * tforms(j).T;
    end
    for j = 1:numImages
        [xlim(j, :), ylim(j, :)] = outputLimits(tforms(j), [1 imageSize(j, 2)], [1 imageSize(j, 1)]);
    end

    % Create the panorama.
    for j = 1:numImages

        I = readimage(ImageDataStore, j);

        % Transform I into the panorama.
        warpedImage = imwarp(I, tforms(j), 'OutputView', panoramaView);

        % Generate a binary mask.
        mask = imwarp(true(size(I,1),size(I,2)), tforms(j), 'OutputView', panoramaView);

        % Overlay the warpedImage onto the panorama.
        panorama = step(blender, panorama, warpedImage, mask);
    end

    figure
    imshow(panorama)

    if useHarris
        file_name = string("S" + string(num) + "-panorama.png");
        imwrite(panorama,file_name,'png');
    end
end