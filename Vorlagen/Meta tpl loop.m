%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
% anpassen: Template-Batch f�r eine Person als Run-Job eintragen, 
% also d:\fMRI\Batch\DicImp_tpl.m �berschreiben
% for subj = n:m Z�hler der Pbd/Ordnernummer eintragen von:bis
% Ordnerpfad und die ersten,gleichbleibenden Buchstaben der Ordnernamen
% �berschreiben
% ggf. in 02d Anzahl der Stellen (d=digits, also 2 Stellen) der Nummerierung �ndern
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.runjobs.jobs = {'d:\fMRI\Batch\DicImp_tpl.m'};
for subj = 1:3
matlabbatch{1}.cfg_basicio.runjobs.inputs{subj}{1}.indir = ...
    {['D:\fMRI\Test-Dicom\pb' sprintf('%02d',subj)]};
end
matlabbatch{1}.cfg_basicio.runjobs.save.dontsave = false;
matlabbatch{1}.cfg_basicio.runjobs.missing = 'skip';
