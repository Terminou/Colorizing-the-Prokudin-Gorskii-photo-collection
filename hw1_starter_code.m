clc;
clear;
% name of the input file
imname = 'lady.png';

% read in the image
fullim = imread(imname);

% convert to double matrix
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);

% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

% create a color image (3D array)
rgbNotAligned(:,:,1) = R;
rgbNotAligned(:,:,2) = G;
rgbNotAligned(:,:,3) = B;
figure('Name','Unaligned image');imshow(rgbNotAligned);
%imwrite(rgbNotAligned, 'notAligned - lady.png');


% crop image borders (percentage is 10%)
B = crop(B, 0.119);
G = crop(G, 0.119);
R = crop(R, 0.119);
cropped = cat(3,R,G,B);
figure('Name','Borderless unaligned image');imshow(cropped);
%imwrite(cropped, 'borderless - lady.png');

% Align the channels 

% SSD Alignment
offsetG = alignSSD(G,B);
offsetR = alignSSD(R,B);
alignedG = circshift(G, offsetG);
alignedR = circshift(R, offsetR);
aligned = cat(3,alignedR,alignedG,B);
figure('Name','SSD aligned image'); imshow(aligned);
pngName = "SSDaligned - " + imname;
imwrite(aligned, pngName);


% NCC Alignment
NCCoffsetG = alignNCC(G,B);
NCCoffsetR = alignNCC(R,B);
alignedNCC = cat(3,NCCoffsetR,NCCoffsetG,B);
figure('Name','NCC aligned image'); imshow(alignedNCC);
pngName = "NCCaligned - " + imname;
imwrite(alignedNCC, pngName);


% Improve the quality of the aligned image

% Gamma correction
gammaCorrection = imadjust(aligned,[],[],1.5);
figure('Name','Gamma correction'); imshow(gammaCorrection);
%imwrite(gammaCorrection, 'gammaCorrection - lady.png');

% Histogram equalization
histEq = histeq(aligned);
figure('Name','Histeq'); imshow(histEq);
%imwrite(histEq, 'histEq - lady.png');

% HSV color space
HSV = rgb2hsv(aligned);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);

%histeqV = histeq(v);
histeqV = histeq(V);
HSVnew = cat (3, H, S, histeqV);
RGB = hsv2rgb(HSVnew);
figure('Name','HSV histeqV'); imshow(RGB);
%imwrite(RGB, 'HSV - lady.png');

