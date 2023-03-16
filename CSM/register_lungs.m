function register_lungs(pathMain)

for i = 1:3
path = [pathMain,'\pat0',num2str(i),'\'];

moving = niftiread([path,'moving.nii']);

mask = zeros(size(moving));
mask(moving<12000) = 1;
mask(moving>12000) = 0;

niftiwrite(mask,"mask.nii")
movefile ("mask.nii", path)
mkdir TempFile

fixedImg = ([path,'fixed.nii']);
movingImg = ([path,'moving.nii']);
maskImg = ([path,'mask.nii']);
outputDirectory = ('TempFile');
addpath('parameter_files');
paramPath= which('Parameters_Rigid.txt');
parameterFile = (paramPath);

cmd = append('elastix\elastix.exe', ' -f ', fixedImg, ' -m ', movingImg,' -mMask ', maskImg, ' -out ', outputDirectory, ' -p ', parameterFile);
% run ELASTIX
system(cmd);

movefile ('TempFile\TransformParameters.0.txt',path)

outputDirectory = ("TempFile");


% which
inputFile = ([path,'TransformParameters.0.txt']);
cmdT = append('elastix\transformix.exe', ' -def all -out ', outputDirectory, ' -tp ', inputFile);

% run TRANSFORMIX
system(cmdT);

movefile('TempFile\deformationField.nii','TempFile\deformationField_Est.nii')
movefile('TempFile\deformationField_Est.nii',path)

% Delete Temp directory
dirpath = 'TempFile';
delete(fullfile(dirpath, '*'));
rmdir TempFile
end

end