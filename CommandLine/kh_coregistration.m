function kh_coregistration (Path, SubjectName, Task)

% changes the structural image
% VG    - handle for reference image (see spm_vol): = mean image
% VF    - handle for source (moved) image: anatomical image

% vorher Sicherungskopie von strukturellen Bildern erstellen
%  x = spm_coreg(VG,VF,flags)


cd (Path)
P = spm_select('ExtList', Path, '^rf.*');  % evtl. mit diesr Funktion f-Bilder auswählen

meanImage = strcat( Path ,filesep, 'meanf_', Task, '_', SubjectName, '_001.nii') ;

anatomicalImage = strcat (Path, filesep, 's_', SubjectName, '.nii')
parameters = struct ( 'graphics', 1) ;

Coreg = spm_coreg(meanImage,anatomicalImage, parameters)

saveas (gcf

save x