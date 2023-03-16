function wholeThing = myLoop(mainPath, elastixPath,paramPath)
%elastixPath = 'C:\Elastix\elastix-5.1.0-win64\';
%mainPath =  'V:\Ladicky\AB2\cv5\Data\';
folders= {'pat01';'pat02';'pat03'};
params = [];
elastixPathExe = [elastixPath,'elastix.exe'];
transformixPathExe = [elastixPath,'transformix.exe'];

for i = 1:size(paramPath,2)
    params = strcat(params,' -p',{' '},paramPath{i});
end
wholeThing = {};
for i = 1:size(folders,1)
    %creating masks
    fMask = niftiread(strcat(mainPath,folders{i},'\fixed.nii'));
    fMask = uint8(fMask>0);
    niftiwrite(fMask, strcat(mainPath,folders{i},'Temp\fmask.nii'));
    mMask = niftiread(strcat(mainPath,folders{i},'\moving.nii'));
    mMask = uint8(mMask>0);
    niftiwrite(mMask, strcat(mainPath,'Temp\mmask.nii'))
    %paths
    fixed = strcat(' -f',{' '},mainPath,folders{i},'\fixed.nii');
    moving = strcat(' -m',{' '},mainPath,folders{i},'\moving.nii');
    outputDir = strcat(' -out',{' '},mainPath,'Temp\');
    mMask = strcat(' -mMask',{' '},mainPath,'Temp\mmask.nii');
    fMask = strcat(' -fMask',{' '},mainPath,'Temp\fmask.nii');
    wholeThing{i,1} = strcat(elastixPathExe,fixed,moving,outputDir,params,mMask,fMask);
    wholeThing{i,2} = strcat(mainPath,folders{i},'\deformationField_Est.nii');
end
wholeThing{1,3} =strcat(transformixPathExe, ' -def all -out', {' '},mainPath,'Temp -tp', {' '}, mainPath,'Temp\TransformParameters.0.txt');
wholeThing{1,4} =strcat(mainPath,'Temp\deformationField.nii');


end


