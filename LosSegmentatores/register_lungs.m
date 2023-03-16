function register_lungs(path_Data)
% Parameters for registration are a based on work of Fourcade et al. 
% DOI:10.1007/978-3-030-71827-5_13

%% find names of folders
filesAndFolders = dir(path_Data);
folderFlags = [filesAndFolders.isdir];
foldersInfo = filesAndFolders(folderFlags);
folders = {foldersInfo(3:end).name};

%% iterate through folders
for i = 1:length(folders)
    outputPath = 'TempFile\';
    % create temp folder
    if exist("TempFile\","dir")
        rmdir(outputPath,"s")
    end
    mkdir(outputPath)
    %% create strings with paths to images and parameters
    fixedPath = char(strcat(path_Data,'\',folders{i},'\fixed.nii'));
    movingPath = char(strcat(path_Data,'\',folders{i},'\moving.nii'));
%     fMaskPath = "TempFile/fMask.nii";
%     mMaskPath = "TempFile/mMask.nii";
    
%     fixed = niftiread(fixedPath);
%     moving = niftiread(movingPath);
    addpath('parameter_files')
    parametersPath = which("Parameters_Exp.txt");
    % masks creation
%     BW = ones(size(fixed));
%     BW(1:5,:)
%     niftiwrite(uint8(BW),fMaskPath)
%     BW = moving<multithresh(moving,1);
%     niftiwrite(uint8(BW),mMaskPath)

    %% run elastics
    system(['elastix\elastix.exe -f ',fixedPath,' -m ',movingPath,' -out ',outputPath,' -p ',parametersPath]);
%     system(["elastix\elastix.exe -f ",fixedPath," -m ",movingPath," -out ",outputPath," -p ",parametersPath," -fMask ",fMaskPath," -mMask ",mMaskPath]);


    %% read resulting nii a show results

%     registered = niftiread(fullfile(outputPath,"result.0.nii"));
% 
%     figure(i)
%     subplot(1,3,1)
%     imshow(fixed,[])
%     title('Fixed')
%     subplot(1,3,2)
%     imshow(moving,[])
%     title('Moving')
%     subplot(1,3,3)
%     imshow(registered,[])
%     title('Registered')
%     
%     figure(i+3)
%     subplot(1,2,1)
%     imshowpair(fixed,moving)
%     subplot(1,2,2)
%     imshowpair(fixed,registered)
    %% saving deformation map
    system(['elastix\transformix.exe -def all -out ',outputPath,' -tp ',char(fullfile(outputPath,"TransformParameters.0.txt"))])
    
    copyfile(fullfile(outputPath,"deformationField.nii"),fullfile(path_Data,folders{i},"deformationField_Est.nii"))    
end
end