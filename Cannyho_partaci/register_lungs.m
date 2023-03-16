%% registrace s eval
function[] = register_lungs(path)
path = convertCharsToStrings(path);
addpath('parameter_files')
for k = 1:3
    filename_fixed = path+'\pat0'+num2str(k)+'\fixed.nii';
    fixed = niftiread(filename_fixed);
    mask_f = fixed;
    mask_f(mask_f>0)=1;
    
    filename_moving = path+'\pat0'+num2str(k)+'\moving.nii';
    moving = niftiread(filename_moving);
    mask_m = moving;
    mask_m(mask_m>0)=1;
    
    % figure
    % subplot(1,3,1)
    % imshow(fixed,[])
    % title('Refer')
    % subplot(1,3,2)
    % imshow(moving,[])
    % title('Moving')
    % 
    % figure(2)
    % subplot(1,2,1)
    % imshowpair(fixed,moving)
    
   
    
    %% Registration
    mkdir TempFolder
    niftiwrite(mask_m,"TempFolder\mask_m.nii");
    mask_m_path = "TempFolder\mask_m.nii";
    niftiwrite(mask_m,"TempFolder\mask_f.nii");
    mask_f_path = "TempFolder\mask_f.nii";

    params = which('Parameters_Affine.txt');
    
    % registration by Elastix

    cmd = ['elastix\elastix.exe -f ' filename_fixed ' -m ' filename_moving ' -out ' 'TempFolder' ' -mMask ' mask_m_path ' -fMask ' mask_f_path ' -p' params];

    system(strjoin(cmd));
    registered = niftiread("TempFolder\result.0.nii");
    
    % load result nifti
    path_result = 'TempFolder';
    registered = niftiread([path_result '\result.0.nii']);
    
    system('elastix\transformix.exe -def all -out TempFolder -tp  "TempFolder\TransformParameters.0.txt"')
      
    movefile("TempFolder\deformationField.nii", "TempFolder\deformationField_Est.nii")
    movefile("TempFolder\deformationField_Est.nii", path+'\pat0'+num2str(k)) 
    
    rmdir('TempFolder', 's')

%% display

    % figure(2)
    % subplot(1,2,2)
    % imshowpair(fixed, registered)
    
end
end