function register_lungs(path_Data)
MSE=zeros(1,3);
meanVar=zeros(1,3);
    for i=1:3
        cesta=[path_Data,'\Data\pat0',num2str(i),'\'];
        fixed=niftiread([cesta,'fixed.nii']);
        moving=niftiread([cesta,'moving.nii']);
%         m_mask=zeros(size(moving));
%         f_mask=zeros(size(fixed));

%         m_mask(moving<mean(mean(moving)))=1;
%         f_mask(fixed<mean(mean(fixed)))=1;

%         niftiwrite(m_mask,'m_mask.nii');
%         niftiwrite(f_mask,'f_mask.nii');
        mkdir temp

        fix_txt=[' -f ',cesta,'fixed.nii'];
        m_txt=[' -m ',cesta,'moving.nii'];
        base_txt='elastix\elastix.exe';
        out_txt=[' -out ','temp'];

        addpath('parameter_files');
        path=which('Parameters_Affine.txt');
        p_txt=[' -p ',path];

%         path=which('m_mask.nii');
%         m_mask_text=[' -mMask ',path];
%         path=which('f_mask.nii');
%         f_mask_text=[' -fMask ',path];

        com =[base_txt,fix_txt,m_txt,out_txt,p_txt];%,m_mask_text,f_mask_text];
        system(com);
        
        addpath('temp');
        base_txt='elastix\transformix.exe';
        in_img=' -def all';
        path=which('TransformParameters.0.txt');
        tp_txt=[' -tp ',path];
        com=[base_txt,in_img,out_txt,tp_txt];
        system(com);

        def=niftiread(which('deformationField.nii'));
        niftiwrite(def,[cesta,'deformationField_Est.nii']);

        rmdir temp s
    end
end