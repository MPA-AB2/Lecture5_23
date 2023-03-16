%% registrace s eval

clear all
close all
clc
addpath(genpath('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23'))

filename = 'Data\pat01\fixed.nii';
fixed = niftiread(filename);

filename = 'Data\pat01\moving.nii';
moving = niftiread(filename);

figure(17)
subplot(1,3,1)
imshow(fixed,[])
title('Refer')
subplot(1,3,2)
imshow(moving,[])
title('Moving')

figure(2)
subplot(1,2,1)
imshowpair(fixed,moving)



%% Registration

% registratio by Elastix
cesta='C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23';

aktualnipat='pat01';

fixedpath = [cesta '\Data\Data\' aktualnipat '\fixed.nii'];
movingpath = [cesta '\Data\Data\' aktualnipat '\moving.nii'];
vystup = [cesta '\Data\Data\' aktualnipat];

param1 = 'C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\parameter_files\Parameters_Affine.txt';

param2 = 'C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\parameter_files\Parameters_Custom.txt';

transparm=[vystup '\TransformParameters.0.txt'];

[~] = system(['C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe -f ', fixedpath ' -m ',movingpath,' -out ',vystup,' -p ',param1]);
movingpathafteraffine=[cesta '\Data\Data\' aktualnipat '\result.0.nii'];
[~] = system(['C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe -f ', fixedpath ' -m ',movingpath,' -out ',vystup,' -p ',param2]);
[~] = system(['C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\transformix.exe',' -def ', ' all ',' -out ',vystup,' -tp ',transparm]);



% 
% [~,help] = system('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\elastix.exe --help')
% [~,help] = system('C:\Users\xrycht01\Documents\MPA-AB2\Lecture5_23\iPT_01\elastix\elastix-5.1.0-win64\transformix.exe --help')



% load result nifti
path_result = vystup;
registered = niftiread([path_result '\result.0.nii']);

deformation = niftiread('deformationField_Est.nii');
figure
imshow(deformation(:,:,:,1,1),[])


deformation = niftiread('deformationField.nii');
figure
imshow(deformation(:,:,:,1,1),[])

%% evaluation 

path_Def_GT = [vystup]; %'\deformationField.nii'
%path_Def_Est = [vystup '\deformationField_Est.nii'];
[MSE,STD] = eval_lung([path_Def_GT])


%% display

figure(17)
subplot(1,3,3)
imshow(registered,[])
title('registered')

figure(2)
subplot(1,2,2)
imshowpair(fixed, registered)
