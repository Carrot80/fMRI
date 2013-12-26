%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.cfg_named_dir.name = 'NIFTI-Ordner';
matlabbatch{1}.cfg_basicio.cfg_named_dir.dirs = {'<UNDEFINED>'};
matlabbatch{2}.cfg_basicio.file_fplist.dir(1) = cfg_dep;
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).tname = 'Directory';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(1).value = 'dir';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).sname = 'Named Directory Selector: NIFTI-Ordner(1)';
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.cfg_basicio.file_fplist.dir(1).src_output = substruct('.','dirs', '{}',{1});
matlabbatch{2}.cfg_basicio.file_fplist.filter = '^f.*';
matlabbatch{2}.cfg_basicio.file_fplist.rec = 'FPList';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1) = cfg_dep;
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).tname = 'Directory';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).tgt_spec{1}(1).value = 'dir';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).sname = 'Named Directory Selector: NIFTI-Ordner(1)';
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.cfg_basicio.cfg_cd.dir(1).src_output = substruct('.','dirs', '{}',{1});
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1) = cfg_dep;
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).tname = 'NIfTI Image(s)';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).tgt_spec{1}(1).name = 'class';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).tgt_spec{1}(1).value = 'cfg_files';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).sname = 'File Selector (Batch Mode): Selected Files (^f.*)';
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1});
matlabbatch{4}.cfg_basicio.call_matlab.inputs{1}.images(1).src_output = substruct('.','files');
matlabbatch{4}.cfg_basicio.call_matlab.outputs = {};
matlabbatch{4}.cfg_basicio.call_matlab.fun = @display_and_print;
