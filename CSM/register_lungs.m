function register_lungs(path)
cd(path)
subfolders = dir;
subfolders = subfolders(3:end,1); 

for i = 3:length(subfolders)
moving = niftiread([subfolders(i).name,'/moving.nii']);

mask = zeros(size(moving));
mask(moving<9500) = 1;
mask(moving>9500) = 0;
niftiwrite(mask,"mask.nii")
movefile ("mask.nii", subfolders(i).name)

mkdir TempFile

fixedImg = ([subfolders(i).name,'/fixed.nii']);
movingImg = ([subfolders(i).name,'/moving.nii']);
maskImg = ([subfolders(i).name,'/mask.nii']);
outputDirectory = ('TempFile');
parameterFile = ('parameter_files/Parameters_Rigid.txt');

cmd = append('elastix\elastix.exe', ' -f ', fixedImg, ' -m ', movingImg,' -mMask ', maskImg, ' -out ', outputDirectory, ' -p ', parameterFile);
% run ELASTIX
system(cmd);

movefile ('TempFile/TransformParameters.0.txt',subfolders(i).name)

outputDirectory = ("TempFile");
parameterFile = ("parameter_files/Parameters_Rigid.txt");
inputFile = ([subfolders(i).name,'/TransformParameters.0.txt']);
cmdT = append('elastix\transformix.exe', ' -def all -out ', outputDirectory, ' -tp ', inputFile);

% run TRANSFORMIX
system(cmdT);

movefile('TempFile/deformationField.nii','TempFile/deformationField_Est.nii')
movefile('TempFile/deformationField_Est.nii',subfolders(i).name)

% Delete Temp directory
dirpath = 'TempFile';
delete(fullfile(dirpath, '*'));
rmdir TempFile

end






end