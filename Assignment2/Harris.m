function Points = Harris(pic)
    sob = [-1 0 1; -2 0 2; -1 0 1];
    gaus = fspecial("gaussian", 5, 1);
    DoG = conv2(gaus, sob);

    ix = imfilter(pic, DoG);
    iy = imfilter(pic, DoG');
    ix2 = imfilter(ix .* ix, gaus);
    iy2 = imfilter(iy .* iy, gaus);
    ixiy = imfilter(ix .* iy, gaus);

    harrisCorners = ix2 .* iy2 - ixiy .* ixiy - 0.05 * (ix2 + iy2) .^ 2;

    localMax = imdilate(harrisCorners, ones(3));
    Points = (harrisCorners == localMax) .* (harrisCorners > 0.00001);
end