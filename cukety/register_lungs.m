function register_lungs(pth_data)
% function

%% Initialization
list_pat = dir(pth_data);
pth_par = which('Parameters_BSpline.txt');



pth_temp = what('TempFile');
pth_temp = pth_temp.path;

for idx = 3:length(list_pat)
    pth_pat = [list_pat(idx).folder,'\',list_pat(idx).name]

filename_fixed = [list_pat(idx).folder,'\',list_pat(idx).name,'\fixed.nii'];
% fixed = niftiread(filename);

filename_moving = [list_pat(idx).folder,'\',list_pat(idx).name,'\moving.nii'];
% moving = niftiread(filename);

if ~isdir(pth_data + "\TempFile")
    mkdir(pth_data + "\TempFile")
end
% registration by Elastix
pth_final = "elastix\elastix.exe -f " + filename_fixed +...
    " -m " + filename_moving + ...
    " -p " + pth_par + ...
    " -out " + pth_temp;

system(pth_final);

pth_elastic = "elastix\transformix.exe -def all -out " + pth_temp + " -tp " + pth_temp + "\TransformParameters.0.txt";

system(pth_elastic)

copyfile(pth_temp + "\deformationField.nii", pth_pat + "\deformationField_Est.nii")
% registered = niftiread(path_data +"TempFile\result.0.nii");

% figure(2)
% subplot(1,2,2)
% imshowpair(fixed, registered)

end



end

