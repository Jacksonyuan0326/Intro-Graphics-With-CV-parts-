HP = im2double(rgb2gray(imread(['mydog.png'])));
LP = im2double(rgb2gray(imread('phone.png')));

%Visualize kernels
sob = [-1 0 1;-2 0 2; -1 0 1];
guask = fspecial('gaussian',18,2.5);
surf(guask);
HPfilt=imfilter(HP, gausk);
imwrite(HPfilt,'HP-filt.png');
LPfilt=imfilter(LP, gausk);
imwrite(LPfilt,'LP-filt.png');
DoG = conv2(gausk,sob);
surf(DoG)
imshow(DoG);
HP_filt = imfilter(HP, DoG);
imshow(HP_filt);
LP_filt = imfilter(LP, DoG);
imshow(LP_filt);
hpdogfiltfreq = abs(fftshift(fft2(HP_filt)))/50;
imshow(hpdogfiltfreq);
 lpdogfiltfreq = abs(fftshift(fft2(LP_filt)))/50;
imshow(lpdogfiltfreq);


%anti-aliasing
hpfiltfreq = abs(fftshift(fft2(LPfilt)))/20;
imwrite(hpsubfreq)
imwrite(hpfiltfreq,'HP-filt-freq.png');
lpfiltfreq = abs(fftshift(fft2(LPfilt)))/20;
imshow(lpfiltfreq)
imwrite(lpfiltfreq,'LP-filt-freq.png');
imwrite(HPsub,'HP-sub2.png')
imwrite(LPsub,'LP-sub2.png')
imwrite(hpsubfreq,'HP-sub2-freq.png')
imwrite(lpsubfreq,'LP-sub2-freq.png')
hpsub4 = HP(1:4:end);
lpsub4 = LP(1:4:end);
hpsub4 = HP(1:4:end, 1:4:end);
imshow(hpsub4);
lpsub4 = LP(1:4:end,1:4:end);
imshow(lpsub4);
hpsubfreq = abs(fftshift(fft2(HPsub)))/50;
lpsubfreq = abs(fftshift(fft2(LPsub)))/50;
imwrite(hpsub4,'HP-sub4-freq.png');
imwrite(lpsub4,'LP-sub4-freq.png');
imshow(lpsubfreq);
imshow(hpsubfreq);
gradx = imfilter(HP,sob);
imshow(abs(gradx));
grady = imfilter(HP,sob');
gradmag = sqrt(gradx .^2 + grady .* grady);
imshow(gradmag);
ken = fspecial('gaussian', 10 ,3);
hpsub2smooth = imfilter(HPsub,ken);
imshow(hpsub2smooth);
ken2 = fspecial('gaussian', 5, 3);
 hpsub4smooth = imfilter(hpsub4,ken2);
imshow(hpsub4smooth)
imwrite(hpsub4smooth,'HP-sub4-aa.png');
 hpsub2smoothfreq = abs(fftshift(fft2(hpsub2smooth)))/50;
imshow(hpsub2smoothfreq);


%canny HP
[cannyedge, thresh] = edge(HP,'canny');
HP_canny_high = im2double(edge(HP, 'canny', [0.09 0.093]));
imshow(HP_canny_high);
 imwrite(HP_canny_high,'HP-canny-highhigh.png');
 HP_canny_low = im2double(edge(HP, 'canny', [0.04 0.05]));
imshow(HP_canny_low);
imwrite(HP_canny_low,'HP-canny-lowlow.png');
HP_canny_lowhigh = im2double(edge(HP,'canny', [0.085 0.087]));
imshow(HP_canny_lowhigh);
imwrite(HP_canny_lowhigh,'HP-canny-lowhigh.png');
HP_canny_highlow = im2double(edge(HP,'canny', [0.055 0.06]));
imshow(HP_canny_highlow);
imwrite(HP_canny_highlow,'HP-canny-highlow.png');
HP_canny_optimal = im2double(edge(HP,'canny', [0.075 0.077]));
imshow(HP_canny_optimal);
imwrite(HP_canny_optimal,'HP-canny-optimal.png');

%canny LP
[cannyedge, thresh] = edge(LP,'canny');
LP_canny_high = im2double(edge(LP, 'canny', [0.031 0.03115]));
imshow(LP_canny_high);
imwrite(LP_canny_high,'LP-canny-highhigh.png');
LP_canny_low = im2double(edge(LP, 'canny', [0.01254 0.01315]));
imshow(LP_canny_low);
imwrite(LP_canny_low,'LP-canny-lowlow.png');
 LP_canny_optimal = im2double(edge(LP, 'canny', [0.0225 0.0227]));
imshow(LP_canny_optimal);
imwrite(LP_canny_optimal,'LP-canny-optimal.png');
LP_canny_lowhigh = im2double(edge(LP, 'canny', [0.028 0.029]));
imshow(LP_canny_lowhigh);
imwrite(LP_canny_lowhigh,'LP-canny-lowhigh.png');
LP_canny_highlow = im2double(edge(LP, 'canny', [0.02 0.021]));
imshow(LP_canny_highlow);
imwrite(LP_canny_highlow,'LP-canny-highlow.png');
