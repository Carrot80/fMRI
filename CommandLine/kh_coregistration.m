% changes the structural image

% VG    - handle for reference image (see spm_vol): = mean image
% VF    - handle for source (moved) image: anatomical image

% vorher Sicherungskopie von strukturellen Bildern erstellen
%  x = spm_coreg(VG,VF,flags)
spm_select() % evtl. mit diesr Funktion f-Bilder auswählen

meanImage = strcat( 'D:\kirsten_thesis\data\controls\zzz_ca\fMRI\nifti\test' ,filesep, 'meanf_VG_zzz_ca_001.nii')
anatomicalImage = strcat ('D:\kirsten_thesis\data\controls\zzz_ca\MRI', filesep, 's_zzz_ca.nii')
parameters = struct ( 'graphics', 1) ;

x = spm_coreg(meanImage,anatomicalImage, parameters)

save x