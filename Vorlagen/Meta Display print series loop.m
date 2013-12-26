%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.runjobs.jobs = {'d:\fMRI\Batch\Display print series tpl.m'};
for subj = 1:3
matlabbatch{1}.cfg_basicio.runjobs.inputs{subj}{1}.indir = ...
    {['D:\fMRI\Test-Nifti\pb' sprintf('%02d',subj)]};
end
matlabbatch{1}.cfg_basicio.runjobs.save.dontsave = false;
matlabbatch{1}.cfg_basicio.runjobs.missing = 'skip';
