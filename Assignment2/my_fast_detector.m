function [points, Visual] = my_fast_detector(image, threshold, useHarris)
    
    % Convert image to grayscale and get its size
    image = rgb2gray(image);
    [height, width, ~] = size(image); 
    
    % Convert the image to double
    image = im2double(image);
    
    % Initialize the points matrix to zeros
    points = zeros(size(image));
    
    % Define the bitmask for the FAST corner detector
    bitmask = [0 0 1 1 1 0 0;
               0 1 0 0 0 1 0;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               0 1 0 0 0 1 0;
               0 0 1 1 1 0 0];
    bitmask = double(bitmask);

    % Display the input image
    figure('visible', 'on');
    imshow(image);
    
    tic;
    
    % Run the FAST detector on the image to detect corners
    for i = 4 : height - 3  
        for j = 4 : width - 3
            points = FAST_detector(i, j, image, points, threshold, bitmask);
        end  
    end
    
    % Apply the Harris corner detector if required
    if useHarris
        points = Harris(image) & points;
    end
    
    % Apply non-maximum suppression to get only the best corner in each 4x4 block
    points = NonMaxSuppression(points);
    
    % Plot the detected corners on the image
    %hold on;
    point = [];
    for j = 4 : width - 3
        for i = 4 : height - 3
            if points(i, j) ~= 0               
                plot(j, i, 'go');
                point = [point; i, j];
            end
        end  
    end
    %hold off;

    % Capture the figure and return the image as Visual
    F = getframe;
    Visual = F.cdata;
    
    % Return the coordinates of the detected corners
    points = point;

    toc;
end

function points = FAST_detector(i,j,image,points,threshold,bitmask)
        
        n1 = abs(image(i-3,j)-image(i,j));
        n5 = abs(image(i,j+3)-image(i,j));
        n9 = abs(image(i+3,j)-image(i,j));
        n13 = abs(image(i,j-3)-image(i,j));
    
        P1=n1>threshold;  
        P9=n9>threshold;  
        P5=n5>threshold;  
        P13=n13>threshold;
         

        if sum([P1 P9 P5 P13])>=3 
            block=image(i-3:i+3,j-3:j+3);  
            block=block.*bitmask;
            blockp1 = block + bitmask;
            pos=find(blockp1);  
            block1=(block(pos)-image(i,j))/threshold;  
            block2=fix(block1);

            level = sum(abs(block(pos)-image(i,j)));

            newblock = FormatBlock(block2);

            count = 1;
                        
            for k=1:15
                if newblock(k) > 0 && newblock(k+1) > 0
                    count = count+1;
                elseif newblock(k) < 0 && newblock(k+1) < 0
                    count = count +1;
                else
                    count = 1;
                end  
            end

            if (newblock(1) > 0 && newblock(16) > 0) || (newblock(1) < 0 && newblock(16) < 0)

                count = count + 1;
            end

            if count>=20  
                %plot(j,i,'go');
                points(i,j) = level;
            end
                        
        end 

end

%Best corner in every 4*4 block
function Maxpoints = NonMaxSuppression(points)
    Maxpoints = points;
    [x,y] = size(points); 
    
    for i = 4 : x-4
        for j = 4 : y-4
            indices = [NoExBound(i-10:x, x), NoExBound(j-10:y, y)];
            for k = 1 : length(indices)
                if (k ~= 111)
                    idx = indices(k,:);
                    if (Maxpoints(i,j) < Maxpoints(idx(1), idx(2)))
                        Maxpoints(i,j) = 0;
                        break;
                    end
                end
            end
        end
    end
end

function n = NoExBound(n,m)
    n = max(1, min(n,m));
end

function newblock = FormatBlock(block)
    newblock = zeros(4,4);
    indices = [1, 2, 3, 5, 7, 9, 11, 13, 16, 15, 14, 12, 10, 8, 6, 4];
    for i = 1:length(indices)
        newblock(i) = block(indices(i));
    end
end