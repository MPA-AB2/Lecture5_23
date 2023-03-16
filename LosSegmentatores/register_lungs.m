function register_lungs(path_Data)
% Parameters for registration are a part of work of Fourcade et al. 
% DOI:10.1007/978-3-030-71827-5_13
%% find names of folders
% path_Data = "C:\Users\xnantl01\MPA-AB2\Lecture5_23\Data";
filesAndFolders = dir(path_Data);
folderFlags = [filesAndFolders.isdir];
foldersInfo = filesAndFolders(folderFlags);
folders = {foldersInfo(3:end).name};

for i = 1:length(folders)
    outputPath = ".\TempFile\";
    if exist(".\TempFile\","dir")
        rmdir(outputPath,"s")
        mkdir(outputPath)
    end
    fixedPath = strcat(path_Data,'\',folders{i},'\fixed.nii');
    movingPath = strcat(path_Data,'\',folders{i},'\moving.nii');
    fMaskPath = "./TempFile/fMask.nii";
    mMaskPath = "./TempFile/mMask.nii";

    fixed = niftiread(fixedPath);
    moving = niftiread(movingPath);
    
%     parametersPath = ".\parameter_files\Parameters_Exp.txt";
    parametersPath = ".\parameter_files\Parameters_Git.txt";
%     parametersPath = ".\parameter_files\Parameters_Affine_v2.txt";
%     parametersPath = ".\parameter_files\Parameters_Par0049.txt";
    % masks
%     BW = fixed<multithresh(fixed,1);
%     niftiwrite(uint8(BW),fMaskPath)
%     BW = moving<multithresh(moving,1);
%     niftiwrite(uint8(BW),mMaskPath)

    system(".\elastix\elastix.exe -f "+ fixedPath + " -m " + movingPath + " -out " + outputPath + " -p " + parametersPath);
%     system(".\elastix\elastix.exe -f "+ fixedPath + " -m " + movingPath + " -out " + outputPath + " -p " + parametersPath + " -fMask " + fMaskPath + " -mMask " + mMaskPath);


    % read resulting nii a show results

    registered = niftiread(fullfile(outputPath,"result.0.nii"));

    figure(1)
    subplot(1,3,1)
    imshow(fixed,[])
    title('Fixed')
    subplot(1,3,2)
    imshow(moving,[])
    title('Moving')
    subplot(1,3,3)
    imshow(registered,[])
    title('Registered')
    
    figure(2)
    subplot(1,2,1)
    imshowpair(fixed,moving)
    subplot(1,2,2)
    imshowpair(fixed,registered)
    % saving deformation map
    system(".\elastix\transformix.exe -def all -out " + outputPath + " -tp " + fullfile(outputPath,"TransformParameters.0.txt"))
    
    copyfile(fullfile(outputPath,"deformationField.nii"),fullfile(path_Data,folders{i},"deformationField_Est.nii"))    
end
end