
function fmri_for_all_subjects  

    PatientFolder = 'D:\kirsten_thesis\data\patients\';
    ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    
    fmriSelectSubjects (PatientFolder)
    fmriSelectSubjects (ControlsFolder)
    
end


function fmriSelectSubjects (Mainfolder)

    List = dir( Mainfolder );

     for i = 3 : size (List)
      if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
          SubjectPath = strcat(Mainfolder, List(i,1).name) ;
          SubjectName = List(i,1).name  
          
          [Path] = MakePath(SubjectPath, SubjectName)
%           kh_LateralityCurves (SubjectName, Path, 'Fluency', 'Broca', 1 ) % no voxelcount
%           kh_LateralityCurves (SubjectName, Path,'Fluency', 'Wernicke', 1 ) % 1=voxelcount; method.thr5=1 (Li-curves, voxel value)
%           kh_LateralityCurves (SubjectName, Path,'Fluency', 'Wernicke', 1 ) % 1=voxelcount; method.thr5=1 (Li-curves, voxel value)
%           kh_lateralityIndex_Bootstrap (SubjectName, Path, 'Fluency', 'Broca', 1 ) 
%           kh_lateralityIndex_Bootstrap (SubjectName, Path, 'Fluency', 'Wernicke', 1 )
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Broca', 3.15895441, 'p_001', 1 ) 
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Wernicke', 3.15895441, 'p_001', 1 ) % one tailed bei 198 degrees of freedom
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Broca', 2.35756115 , 'p_01', 1 ) 
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Wernicke', 2.35756115 , 'p_01', 1 ) 
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Broca', 1.65754432 , 'p_05', 1 ) 
          kh_laterality_thr (SubjectName, Path, 'Fluency', 'Wernicke', 1.65754432 , 'p_05', 1 ) 
      end
    end
 
end


function kh_LateralityCurves (SubjectName, Path, TaskFullName, Mask, VC)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\10_Lateralization.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, TaskFullName, filesep);
cd(PathStatistics)

matlabbatch{1, 1}.spm.tools.LI_cfg.spmT{1, 1}=strcat(PathStatistics, 'wspmT_0001.img,1'); 
matlabbatch{1, 1}.spm.tools.LI_cfg.inmask.im11{1, 1} = strcat('D:\kirsten_thesis\data\all\ROIsForAfni\AAL\', Mask, '_left_dil.nii,1');
matlabbatch{1, 1}.spm.tools.LI_cfg.inmask.im11{2, 1} = strcat('D:\kirsten_thesis\data\all\ROIsForAfni\AAL\', Mask, '_right_dil.nii,1');
matlabbatch{1, 1}.spm.tools.LI_cfg.method.thr5 = 1;
matlabbatch{1, 1}.spm.tools.LI_cfg.vc = VC;
matlabbatch{1, 1}.spm.tools.LI_cfg.outfile = strcat('LI_Curves_', Mask, '.txt');


spm_jobman('run', matlabbatch)


end

function kh_lateralityIndex_Bootstrap (SubjectName, Path, TaskFullName, Mask, VC)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\10_Lateralization.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, TaskFullName, filesep);
cd(PathStatistics)
matlabbatch{1, 1}.spm.tools.LI_cfg.spmT{1, 1}=strcat(PathStatistics, 'wspmT_0001.img,1'); 
matlabbatch{1, 1}.spm.tools.LI_cfg.inmask.im11{1, 1} = strcat('D:\kirsten_thesis\data\all\ROIsForAfni\AAL\', Mask, '_left_dil.nii,1');
matlabbatch{1, 1}.spm.tools.LI_cfg.inmask.im11{2, 1} = strcat('D:\kirsten_thesis\data\all\ROIsForAfni\AAL\', Mask, '_right_dil.nii,1');

matlabbatch{1, 1}.spm.tools.LI_cfg.method=rmfield(matlabbatch{1, 1}.spm.tools.LI_cfg.method, 'thr5')
matlabbatch{1, 1}.spm.tools.LI_cfg.method.thr7 = 1;
matlabbatch{1, 1}.spm.tools.LI_cfg.vc = VC;
matlabbatch{1, 1}.spm.tools.LI_cfg.outfile = strcat('LI_Bootstrap_', Mask, '.txt');

spm_jobman('run', matlabbatch)

end


function kh_laterality_thr (SubjectName, Path, TaskFullName, Mask, Thr, p, VC)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\10_Lateralization_thr.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, TaskFullName, filesep);
cd(PathStatistics)

if exist (strcat('LI_', Mask, '_', p, '.txt'), 'file');
    delete ( strcat('LI_', Mask, '_', p, '.txt'));
end

matlabbatch{1, 1}.spm.tools.LI_cfg.spmT{1, 1}=strcat(PathStatistics, 'wspmT_0001.img,1'); 
matlabbatch{1, 1}.spm.tools.LI_cfg.inmask.im11{1, 1} = strcat('D:\kirsten_thesis\data\all\ROIsForAfni\AAL\', 'w',Mask, '_left_dil.nii,1');
matlabbatch{1, 1}.spm.tools.LI_cfg.method.thr1 = Thr ;
matlabbatch{1, 1}.spm.tools.LI_cfg.outfile = strcat('LI_', Mask, '_', p, '.txt');

spm_jobman('run', matlabbatch)

end



function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Fluency') ;
        
 end
