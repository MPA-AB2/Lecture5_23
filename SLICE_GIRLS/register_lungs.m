function register_lungs(path_data)

addpath('parameter_files')

for i = 1:3
    pat = ['0',num2str(i)];

    filename = [path_data, 'pat', pat, '\fixed.nii'];
    fixed = niftiread(filename);

    filename = [path_data, 'pat', pat, '\moving.nii'];
    moving = niftiread(filename);

    %% Delete and recreate TempFile dir
    if exist([path_data, 'TempFile'],'dir')
        rmdir([path_data, 'TempFile'],'s')
    end
    mkdir([path_data, 'TempFile'])

    %% Save paths
    fixedFile = [path_data, 'pat', pat, '\fixed.nii'];
    movingFile = [path_data, 'pat', pat, '\moving.nii'];
    fMask = [path_data, 'maskFix.nii'];
    mMask = [path_data, 'maskMov.nii'];
    outputDir = [path_data, 'TempFile'];
    
    %% Create and save binary mask
%     tmp2 = imbinarize(im2double(moving), 0.6); % lungs
%     maskMov = ~tmp2;
%     niftiwrite(int16(maskMov), 'maskMov.nii');
%     
%     tmp2 = imbinarize(im2double(fixed), 0.6);
%     maskFix = ~tmp2;
%     niftiwrite(int16(maskFix), 'maskFix.nii');
    
    %% run ELASTIX - rigid
    paramFile = which('Parameters_Affine2.txt');
%     command = ['elastix\elastix.exe -f ', fixedFile, ' -m ', movingFile, ' -out ', outputDir, ' -p ', paramFile, ' -mMask ', mMask, ' -fMask ', fMask];
    command = ['elastix\elastix.exe -f ', fixedFile, ' -m ', movingFile, ' -out ', outputDir, ' -p ', paramFile];
    system(command)
    
%     % new moving file - after rigid transform
%     movingFile = [path_data, 'TempFile\result.0.nii'];
%     moving = niftiread(movingFile);
%     
%     % new moving mask
%     maskMov = imbinarize(im2double(moving), 0.6);
%     maskMov = ~maskMov;
%     niftiwrite(int16(maskMov),'maskMov.nii');
%     
%     %% run ELASTIX - affine
%     paramFile = which('Parameters_Bspline.txt');
% %     command = ['elastix\elastix.exe -f ', fixedFile, ' -m ', movingFile, ' -out ', outputDir, ' -p ', paramFile, ' -mMask ', mMask, ' -fMask ', fMask];
%     command = ['elastix\elastix.exe -f ', fixedFile, ' -m ', movingFile, ' -out ', outputDir, ' -p ', paramFile];
%     system(command)

    %% run TRANSFORMIX
    transformParam = [path_data, 'TempFile\TransformParameters.0.txt'];
    command = ['elastix\transformix.exe -def all -out ', outputDir, ' -tp ', transformParam];
    system(command)

    % copy file to Pat folder
    copyfile([path_data, 'TempFile\deformationField.nii'], [path_data, 'pat', pat, '\deformationField_Est.nii']);

    %% Show res
%     registered = niftiread([path_data, 'TempFile\result.0.nii']);
%     
%     figure(2)
%     subplot(1,2,1)
%     imshowpair(fixed,moving)
%     subplot(1,2,2)
%     imshowpair(fixed, registered)
% 
%     pause;
    
end

end