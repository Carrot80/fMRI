function kh_coregistration (Path_Nifti, Path_MRI, SubjectName, Task)

% changes the structural image
% VG    - handle for reference image (see spm_vol): = mean image
% VF    - handle for source (moved) image: anatomical image

% vorher Sicherungskopie von strukturellen Bildern erstellen
%  x = spm_coreg(VG,VF,flags)


cd (Path_Nifti)
P = spm_select('ExtList', pwd, '^rf.*');  % evtl. mit diesr Funktion f-Bilder auswählen


meanImage = strcat( pwd ,filesep, 'meanf_', 'VG', '_', 'zzz_ca', '_001.nii') ;
anatomicalImage = strcat ('D:\kirsten_thesis\data\controls\zzz_ca\MRI', filesep, 's_', 'zzz_ca', '.nii')

T1_vol = spm_vol(anatomicalImage);
T2_vol = spm_vol(meanImage);

parameters = struct ( 'graphics', 1) ;
Coreg = spm_coreg(T2_vol,T1_vol, parameters)
M = spm_matrix(Coreg);
 Space = spm_get_space(P,M) % P= image filename, M=voxel-to-world mapping
T1_vol.mat=M/T1_vol.mat


parameters = struct ( 'graphics', 1) ;
Coreg = spm_coreg(meanImage,anatomicalImage, parameters)

% Space=spm_get_space(meanImage, M * T2_vol.mat);
% use spm_coreg again to apply the matrix to the file?

%folgendes probieren
% A = spm_vol('A.nii');
% B = spm_vol('B.nii');
% x = spm_coreg(A,B);
% M = spm_matrix(x(:)');
% B.mat = M \ B.mat;   
% spm_reslice([A,B],struct('interp',0,'which',1,'mean',false));

% überprüfen durch ImageCalc! output über GIU und über Commandline


% reslicing target image:
% realigment_parameters = struct('quality' ,0.9, 'fwhm', 5, 'rtm', 1, 'interp', 5)
% files = {anatomicalImage;meanImage}
% spm_reslice(files, realigment_parameters);

% 
% for instance, say i am co-registering T2 image to T1:
% T1_vol = spm_vol(T1);
% T2_vol = spm_vol(T2);
% x = spm_coreg(T2_vol, T1_vol);
% M = spm_matrix(x);
% spm_get_space(T2, M * T2_vol.mat);
% 
% % for re-slicing i usually construct my flags first:
% flags= struct('interp',5,'mask',1,'mean',0,'which',1,'wrap',[0 0 0]');
% % then the files i want to re-slice, source file first (in our example
% T1 image)
% files = {T1;t2}
% spm_reslice(files, flags);


end