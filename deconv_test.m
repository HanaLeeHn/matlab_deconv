close all
clear all
clc

im_org = imread('cameraman.tif');
im_org = im2double(im_org);
[ro,co] = size(im_org);

r = 3*ro; 
c = 3*co;
im = zeros(r,c);
im(ro+1:2*ro, co+1:2*co) = im_org;

h = fspecial('gaussian', [11, 11], 2);
h = h / sum(sum(h));

% g = imfilter(im, h, 'circular'); 
g = imfilter(im, h, 0); 
G = fft2(g,r,c);

H = fft2(h,r,c);
mag_H = sqrt(real(H).^2+imag(H).^2); % abs(H);
Ghat = G.*conj(H)./(mag_H.^2); % G./H;

ghat = real(ifft2( Ghat ));
ghat_crop = ghat(252:507,252:507); % 252:507
figure, imshow(ghat_crop, [])