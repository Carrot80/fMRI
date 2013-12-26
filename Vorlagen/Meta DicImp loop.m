%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.runjobs.jobs = {'d:\fMRI\Batch\DicImp_tpl.m'};
matlabbatch{1}.cfg_basicio.runjobs.inputs{1}{1}.indir = {'D:\fMRI\Test-Dicom\pb01'};
matlabbatch{1}.cfg_basicio.runjobs.inputs{2}{1}.indir = {'D:\fMRI\Test-Dicom\pb02'};
matlabbatch{1}.cfg_basicio.runjobs.inputs{3}{1}.indir = {'D:\fMRI\Test-Dicom\pb03'};
matlabbatch{1}.cfg_basicio.runjobs.save.dontsave = false;
matlabbatch{1}.cfg_basicio.runjobs.missing = 'skip';
