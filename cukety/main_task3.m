
%% Initialization

pth_data = "Data\Data\";
% pth_par = which('Parameters_Affine.txt');

if ~isdir("\TempFile")
    mkdir("\TempFile")
end

%% foe every patient

register_lungs(pth_data)

%% evaluation 

% path_Def_GT = 'Data\Data\pat01\deformationField.nii';
% path_Def_Est = 'TempFile\deformationField.nii'; 

[MSE,STD] = eval_lung('Data\Data\')


%% display

% figure(2)
% subplot(1,2,2)
% imshowpair(fixed, registered)
