%% registration elastix-2D

clear all
close all
clc
addpath(genpath('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23'))
load data2.mat
% load data2.mat

figure
subplot(1,3,1)
imshow(fixed,[])
title('Fixed')
subplot(1,3,2)
imshow(moving,[])
title('Moving')




[~,help] = system('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe --help')

[~,elastix_version] = system('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe --version')



%% Registratio - RIGID AND AFFINE + masked affine

% create TempFile, define the parameters and paths
niftiwrite(fixed,'fixed')
niftiwrite(moving,'moving')



% run ELASTIX

cesta='C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\TempFile';


fixed = [cesta '\fixed.nii'];
moving = [cesta '\moving.nii'];
vystup = cesta;
param = 'C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\parameter_files\Parameters_Affine.txt';
fMask = ones(size(fixed));
mMask = zeros(size(moving));
size_moving=size(moving);
for i=1:size_moving(1)
    for i2=1:size_moving(2)
        if moving(i,i2) > 0
            mMask(i,i2)=1;
        end
    end
end
niftiwrite(mMask,'mMask')
niftiwrite(fMask,'fMask')

mMaskcesta=[cesta '\mMask.nii'];
fMaskcesta=[cesta '\fMask.nii'];



[~] = system(['C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe -f ', fixed ' -m ',moving,' -out ',vystup,' -p ',param,' -mMask',mMaskcesta,' -fMask',fMaskcesta]);




% read resulting nii a save to variable - registered
registered = niftiread([vystup '\result.0.nii']);






%% display
load data2.mat
subplot(1,3,3)
imshow(registered,[])
title('Registered')

figure
subplot(1,2,1)
imshowpair(fixed,moving)
subplot(1,2,2)
imshowpair(fixed,registered)
