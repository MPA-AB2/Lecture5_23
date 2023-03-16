% MPA-AB2 - Lecture 5
clear,close,clc
%% call our algorithm for depth calculation
pathData = 'C:\Users\xnantl01\MPA-AB2\Lecture5_23\Data';
register_lungs(pathData);
%% evaluate results
[MSE, meanVar] = eval_lung(pathData);
%% show deformation fields 
% fieldGT = niftiread("C:\Users\xnantl01\MPA-AB2\Lecture5_23\Data\pat01\deformationField.nii");
% fieldEst = niftiread("C:\Users\xnantl01\MPA-AB2\Lecture5_23\Data\pat01\deformationField_Est.nii");
% 
% figure
% subplot 121
% imshow(fieldGT(:,:,1,1,1),[])
% subplot 122
% imshow(fieldEst(:,:,1,1,1),[])