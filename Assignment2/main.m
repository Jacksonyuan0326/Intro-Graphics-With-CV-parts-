%PART 1
    %Import images
    S1_im1 = imread('Pic1/S1-1.jpg');
    S1_im2 = imread('Pic1/S1-2.jpg');
    S2_im1 = imread('Pic2/S2-1.jpg');
    S2_im2 = imread('Pic2/S2-2.jpg');
    S2_im3 = imread('Pic2/S2-3.jpg');
    S2_im4 = imread('Pic2/S2-4.jpg');
    S3_im1 = imread('Pic3/S3-1.jpg');
    S3_im2 = imread('Pic3/S3-2.jpg');
    S3_im3 = imread('Pic3/S3-3.jpg');
    S3_im4 = imread('Pic3/S3-4.jpg');
    S4_im1 = imread('Pic4/S4-1.jpg');
    S4_im2 = imread('Pic4/S4-2.jpg');
    %Put images in an array
    IMS = {S1_im1, S1_im2, S2_im1, S2_im2, S2_im3, S2_im4, S3_im1, S3_im2, S3_im3, S3_im4, S4_im1, S4_im2};
    
    %Resize images
    for i=1:length(IMS)
        [x, y, ~] = size(IMS{i});
        if x > y
            scale = 750/x;
        else
            scale = 750/y;
        end
        IMS{i} = imresize(IMS{i}, scale);
    end
    %Save Images
    imwrite(IMS{1}, 'S1-im1.png');
    imwrite(IMS{2}, 'S1-im2.png');
    imwrite(IMS{3}, 'S2-im1.png');
    imwrite(IMS{4}, 'S2-im2.png');
    imwrite(IMS{5}, 'S2-im3.png');
    imwrite(IMS{6}, 'S2-im4.png');
    imwrite(IMS{7}, 'S3-im1.png');
    imwrite(IMS{8}, 'S3-im2.png');
    imwrite(IMS{9}, 'S3-im3.png');
    imwrite(IMS{10}, 'S3-im4.png');
    imwrite(IMS{11}, 'S4-im1.png');
    imwrite(IMS{12}, 'S4-im2.png');
    %Re-set image variables to update changes
    S1_im1 = IMS{1};
    S1_im2 = IMS{2};
    S2_im1 = IMS{3};
    S2_im2 = IMS{4};
    S2_im3 = IMS{5};
    S2_im4 = IMS{6};
    S3_im1 = IMS{7};
    S3_im2 = IMS{8};
    S3_im3 = IMS{9};
    S3_im4 = IMS{10};
    S4_im1 = IMS{11};
    S4_im2 = IMS{12};
        %re-set images in array
    IMS = {S1_im1, S1_im2, S2_im1, S2_im2, S2_im3, S2_im4, S3_im1, S3_im2, S3_im3, S3_im4, S4_im1, S4_im2};
    %Set all these images to doubles
    for i=1:length(IMS)
        IMS{i} = im2double(IMS{i});
        IMS{i} = rgb2gray(IMS{i});
    end

    %Part 2
    FastImArr = {12};
    FastRImArr = {12};
    VisualArr = {12};
    VisualRArr = {12};
    [FastImArr{1}, VisualArr{1}] = my_fast_detector(S1_im1,0.05,0);
    [FastImArr{2}, VisualArr{2}] = my_fast_detector(S1_im2,0.05,0);
    [FastImArr{3}, VisualArr{3}] = my_fast_detector(S2_im1,0.05,0);
    [FastImArr{4}, VisualArr{4}] = my_fast_detector(S2_im2,0.05,0);
    [FastImArr{5}, VisualArr{5}] = my_fast_detector(S2_im3,0.05,0);
    [FastImArr{6}, VisualArr{6}] = my_fast_detector(S2_im4,0.05,0);
    [FastImArr{7}, VisualArr{7}] = my_fast_detector(S3_im1,0.05,0);
    [FastImArr{8}, VisualArr{8}] = my_fast_detector(S3_im2,0.05,0);
    [FastImArr{9}, VisualArr{9}] = my_fast_detector(S3_im3,0.05,0);
    [FastImArr{10}, VisualArr{10}] = my_fast_detector(S3_im4,0.05,0);
    [FastImArr{11}, VisualArr{11}] = my_fast_detector(S4_im1,0.05,0);
    [FastImArr{12}, VisualArr{12}] = my_fast_detector(S4_im2,0.05,0);
    
    [FastRImArr{1}, VisualRArr{1}] = my_fast_detector(S1_im1,0.05,1);
    [FastRImArr{2}, VisualRArr{2}] = my_fast_detector(S1_im2,0.05,1);
    [FastRImArr{3}, VisualRArr{3}] = my_fast_detector(S2_im1,0.05,1);
    [FastRImArr{4}, VisualRArr{4}] = my_fast_detector(S2_im2,0.05,1);
    [FastRImArr{5}, VisualRArr{5}] = my_fast_detector(S2_im3,0.05,1);
    [FastRImArr{6}, VisualRArr{6}] = my_fast_detector(S2_im4,0.05,1);
    [FastRImArr{7}, VisualRArr{7}] = my_fast_detector(S3_im1,0.05,1);
    [FastRImArr{8}, VisualRArr{8}] = my_fast_detector(S3_im2,0.05,1);
    [FastRImArr{9}, VisualRArr{9}] = my_fast_detector(S3_im3,0.05,1);
    [FastRImArr{10}, VisualRArr{10}] = my_fast_detector(S3_im4,0.05,1);
    [FastRImArr{11}, VisualRArr{11}] = my_fast_detector(S4_im1,0.05,1);
    [FastRImArr{12}, VisualRArr{12}] = my_fast_detector(S4_im2,0.05,1);

imwrite(VisualArr{1},'S1-fast.png','png');
imwrite(VisualArr{5},'S2-fast.png','png');
imwrite(VisualRArr{1},'S1-fastR.png','png');
imwrite(VisualRArr{5},'S2-fastR.png','png');

%%
%For using Harris
Panoramas(1,1);
%%
Panoramas(2,1);
%%
Panoramas(3,1);
%%
Panoramas(4,1);
%%
%For not useing Harris, Do not save

Panoramas(1,0);
%%
Panoramas(2,0);
%%
Panoramas(3,0);
%%
Panoramas(4,0);