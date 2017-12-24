clear all; close all; clc;
%load an image and display it in figure 1
rgb_img = imread('Photo_062011_002.jpg');
image(rgb_img);
%fit plot box tightly around the image data
axis image;
%Change image to grayscale 2D matrix; note elipsis (...)
I = .2989*rgb_img(:,:,1)...
 +.5870*rgb_img(:,:,2)...
 +.1140*rgb_img(:,:,3);
%display grayscaled image in figure 2 with gray(256) colormap
figure; colormap(gray(256)); image(I);
axis image;
whos I
%convert grayscale to single in [0,1] range
S = double(I)/255;
whos S
