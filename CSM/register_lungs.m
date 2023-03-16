function register_lungs(pathMain)

for i = 1:3
path = [pathMain,'\pat0',num2str(i),'\'];
fixed = niftiread([path,'fixed.nii']);
moving = niftiread([path,'moving.nii']);

mMask = zeros(size(moving));
mMask(moving<9500) = 1;
mMask(moving>9500) = 0;

fMask = zeros(size(fixed));
fMask(fixed<9500) = 1;
fMask(fixed>9500) = 0;

niftiwrite(mMask,"mMask.nii")
movefile ("mMask.nii", path)

niftiwrite(fMask,"fMask.nii")
movefile ("fMask.nii", path)

mkdir TempFile
fixedImg = ([path,'fixed.nii']);
movingImg = ([path,'moving.nii']);
mMaskImg = ([path,'mMask.nii']);
fMaskImg = ([path,'fMask.nii']);
outputDirectory = ('TempFile');
paramPath= which('Parameters_Affine.txt');
parameterFile = (paramPath);

cmd = append('elastix\elastix.exe', ' -f ', fixedImg, ' -fMask ', fMaskImg,' -m ', movingImg,' -mMask ', mMaskImg, ' -out ', outputDirectory, ' -p ', parameterFile);
% run ELASTIX
system(cmd);
outputDirectory = ("TempFile");
inputFile = ('TempFile\TransformParameters.0.txt');
cmdT = append('elastix\transformix.exe', ' -def all -out ', outputDirectory, ' -tp ', inputFile);

% run TRANSFORMIX
system(cmdT);

movefile('TempFile\deformationField.nii','TempFile\deformationField_Est.nii')
movefile('TempFile\deformationField_Est.nii',path)
% Deletes TEMP
rmdir TempFile s
end
end