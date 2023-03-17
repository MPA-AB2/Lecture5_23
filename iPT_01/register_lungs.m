function [] = register_lungs(path_Data)

    cesta = path_Data;

    for rep = 1:3
        aktualnipat = ['pat0' num2str(rep)];

        fixedpath = [cesta '\' aktualnipat '\fixed.nii'];
        movingpath = [cesta '\' aktualnipat '\moving.nii'];
        vystup = [cesta '\TempFile'];
        param = ['S:\UBMI\VYUKA\UCITEL\FABO2\2023\Lecture5\last\Lecture5\Lecture5_23\iPT_01' '\parameter_files\Param_me.txt'];
        
        transparm=[vystup '\TransformParameters.0.txt'];

        [~] = system(['elastix\elastix.exe -f ', fixedpath ' -m ',movingpath,' -out ',vystup,' -p ',param]);
        [~] = system(['elastix\transformix.exe',' -def ', ' all ',' -out ',vystup,' -tp ',transparm]);
        
        
        movefile([vystup '\deformationField.nii'],[cesta '\' aktualnipat '\deformationField_Est.nii']);


        pom_vystup = [cesta '\' aktualnipat]
        % load result nifti
        path_result = pom_vystup;



    end
        path_Def_GT = [cesta '\']; %'\deformationField.nii'
        %path_Def_Est = [vystup '\deformationField_Est.nii'];
        [MSE,STD] = eval_lung([path_Def_GT])

end

