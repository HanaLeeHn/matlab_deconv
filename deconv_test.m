im_org = imread('cameraman.tif');
im_org = im2double(im_org);
[ro,co] = size(im_org);

ksize = [11,11];
h = fspecial('gaussian', ksize, 2);
h = h / sum(sum(h));

mtd = 'zero';
% mtd = 'circular';
if strcmp(mtd,'zero')
    im = padarray(im_org,[5,5],'both');
    [r,c] = size(im);
    g = imfilter(im, h, 0);
elseif strcmp(mtd,'circular')
    im = im_org;
    [r,c] = size(im);
    g = imfilter(im, h, 'circular');
end

G = fft2(g,r,c);
H = fft2(h,r,c);
mag_H = sqrt(real(H).^2+imag(H).^2); % abs(H);
Ghat = G.*conj(H)./(mag_H.^2); % G./H;
ghat = real(ifft2( Ghat ));
figure, imshow(ghat, [])