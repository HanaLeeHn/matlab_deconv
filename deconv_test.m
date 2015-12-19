close all
im_org = imread('cameraman.tif');
im_org = im2double(im_org);
[ro,co] = size(im_org);
im = zeros(3*ro, 3*co);
[r,c] = size(im);
im(ro+1:2*ro, co+1:2*co) = im_org;

h = fspecial('gaussian', [11, 11], 2);
h = h / sum(sum(h));
H = fft2(h,r,c);

g = imfilter(im, h, 'circular'); 
G = fft2(g,r,c);

H_mag = sqrt(real(H).^2+imag(H).^2);
%H_mag = abs(H);
restoredf = G.*conj(H)./(H_mag.^2);
%restoredf = G./H;

restored = real(ifft2( restoredf ));
figure, imshow(restored, [])