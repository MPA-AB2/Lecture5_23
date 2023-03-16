function [] = register_lungs(path_Data)

    cesta = path_Data;

    for rep = 1:3
        aktualnipat = ['pat0' num2str(rep)];

        fixedpath = [cesta '\Data\' aktualnipat '\fixed.nii'];
        movingpath = [cesta '\Data\' aktualnipat '\moving.nii'];
        vystup = [cesta '\TempFile'];
        param = [cesta '\parameter_files\Param_me.txt'];
        
        transparm=[vystup '\TransformParameters.0.txt'];

        [~] = system(['elastix\elastix.exe -f ', fixedpath ' -m ',movingpath,' -out ',vystup,' -p ',param]);
        [~] = system(['elastix\transformix.exe',' -def ', ' all ',' -out ',vystup,' -tp ',transparm]);
        
        
        movefile([vystup '\deformationField.nii'],[cesta '\Data\' aktualnipat '\deformationField_Est.nii']);


        pom_vystup = [cesta '\Data\' aktualnipat]
        % load result nifti
        path_result = pom_vystup;



    end
        path_Def_GT = [cesta '\Data']; %'\deformationField.nii'
        %path_Def_Est = [vystup '\deformationField_Est.nii'];
        [MSE,STD] = eval_lung([path_Def_GT])

end

