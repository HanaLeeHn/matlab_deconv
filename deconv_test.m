%% Observed Image 
im_org = imread('cameraman.tif');
im_org = im2double(im_org);
[ro,co] = size(im_org);

ksize = [7,7];
h = fspecial('gaussian', ksize, 2);
h = h / sum(sum(h));

% mtd = 'zero';
mtd = 'circular';
if strcmp(mtd,'zero')
    im = padarray(im_org,[4,4],'both');
    [r,c] = size(im);
    g = imfilter(im, h, 0);
    % g_crop = g(1:256, 1:256);
    % g = g_crop;
elseif strcmp(mtd,'circular')
    im = im_org;
    [r,c] = size(im);
    g = imfilter(im, h, 'circular');
end

%% Deconvolution
G = fft2(g,r,c);
H = fft2(h,r,c);
mag_H = sqrt(real(H).^2+imag(H).^2); % abs(H);
Ghat = G.*conj(H)./(mag_H.^2); % G./H; % inverse filter

% sigma = 0.0005/var(g(:)); % nsr
% Ghat = G.*conj(H)./(sigma+mag_H.^2); % wiener filter

% sigma = 0.00001/var(g(:)); % nsr
% alpha = 0.5;
% Ghat = G.* (conj(H)./mag_H.^2).^alpha .* (conj(H)./(sigma+mag_H.^2)).^(1-alpha); % G./H; % geometric mean filter

ghat = real(ifft2( Ghat ));
figure, imshow(ghat, [])
