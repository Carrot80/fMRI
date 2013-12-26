%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.cfg_named_dir.name = '1_In 2_Out';
matlabbatch{1}.cfg_basicio.cfg_named_dir.dirs = {
                                                 '<UNDEFINED>'
                                                 '<UNDEFINED>'
                                                 }';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1) = cfg_dep;
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).tname = 'Parent Directory';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).tgt_spec{1}(1).value = 'dir';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).sname = 'Named Directory Selector: 1_In 2_Out(2)';
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.cfg_basicio.cfg_mkdir.parent(1).src_output = substruct('.','dirs', '{}',{2});
matlabbatch{2}.cfg_basicio.cfg_mkdir.name = 'NIFTI';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1) = cfg_dep;
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).tname = 'Directory';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(1).value = 'dir';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).sname = 'Named Directory Selector: 1_In 2_Out(1)';
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.cfg_basicio.file_fplist.dir(1).src_output = substruct('.','dirs', '{}',{1});
matlabbatch{3}.cfg_basicio.file_fplist.filter = '.*';
matlabbatch{3}.cfg_basicio.file_fplist.rec = 'FPListRec';
matlabbatch{4}.spm.util.dicom.data(1) = cfg_dep;
matlabbatch{4}.spm.util.dicom.data(1).tname = 'DICOM files';
matlabbatch{4}.spm.util.dicom.data(1).tgt_spec{1}(1).name = 'class';
matlabbatch{4}.spm.util.dicom.data(1).tgt_spec{1}(1).value = 'cfg_files';
matlabbatch{4}.spm.util.dicom.data(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.spm.util.dicom.data(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.spm.util.dicom.data(1).sname = 'File Selector (Batch Mode): Selected Files (.*)';
matlabbatch{4}.spm.util.dicom.data(1).src_exbranch = substruct('.','val', '{}',{3}, '.','val', '{}',{1});
matlabbatch{4}.spm.util.dicom.data(1).src_output = substruct('.','files');
matlabbatch{4}.spm.util.dicom.root = 'flat';
matlabbatch{4}.spm.util.dicom.outdir(1) = cfg_dep;
matlabbatch{4}.spm.util.dicom.outdir(1).tname = 'Output directory';
matlabbatch{4}.spm.util.dicom.outdir(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{4}.spm.util.dicom.outdir(1).tgt_spec{1}(1).value = 'dir';
matlabbatch{4}.spm.util.dicom.outdir(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.spm.util.dicom.outdir(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.spm.util.dicom.outdir(1).sname = 'Make Directory: Make Directory ''NIFTI''';
matlabbatch{4}.spm.util.dicom.outdir(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1});
matlabbatch{4}.spm.util.dicom.outdir(1).src_output = substruct('.','dir');
matlabbatch{4}.spm.util.dicom.convopts.format = 'nii';
matlabbatch{4}.spm.util.dicom.convopts.icedims = 0;
