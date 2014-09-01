

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
%           kh_realign (SubjectName, Path, 'Fluency') % realign and reslice, mean image + other images
%           kh_coreg (SubjectName, Path, 'Fluency') % derzeit estimate and reslice
%           kh_segment (SubjectName, Path, 'Fluency') % segmentiert strukturelle Datei aus Coregister estimate
          kh_smooth (SubjectName, Path, 'Fluency') % kernel of 3 3 3 
          kh_modelspecification (SubjectName, Path, 'Fluency') 
          kh_estimation (SubjectName, Path, 'Fluency')
          kh_contrast_manager (SubjectName, Path, 'Fluency')
          kh_Results_Report (SubjectName, Path, 'Fluency')
          kh_normalizeTmap (SubjectName, Path, 'Fluency')
%           kh_rendersurface (SubjectName, Path, 'Fluency')

      end
 end
 
end

function kh_realign (SubjectName, Path, Task)

fn = strcat ( Path.Nifti.(Task), filesep, 'rf_', Task, '_', SubjectName, '_001.nii')
% if exist (fn, 'file')
%     return
% end

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\01_Realign_Reslice.mat')

cd(strcat(Path.Nifti.(Task)))

 DirFilesTask    = dir(fullfile(Path.Nifti.(Task), 'f*.nii')); 
 
 
 for j=1:length(DirFilesTask)
     matlabbatch{1, 1}.spm.spatial.realign.estwrite.data{1, 1}{j, 1}=strcat(Path.Nifti.(Task), filesep, DirFilesTask(j,1).name)
 end
 
spm_jobman('run', matlabbatch)



end


function kh_coreg (SubjectName, Path, Task)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\02_Coreg_estimate_reslice.mat')

cd(strcat(Path.Nifti.(Task)))

% matlabbatch{1, 1}.spm.spatial.coreg.estimate.ref{1, 1} = strcat(Path.Nifti.(Task), filesep, 'meanf_', Task, '_', SubjectName, '_001.nii,1');
% matlabbatch{1, 1}.spm.spatial.coreg.estimate.source{1, 1}=strcat(Path.Nifti.(Task), filesep, 's_', SubjectName, '.nii,1');

matlabbatch{1, 1}.spm.spatial.coreg.estwrite.ref{1, 1} = strcat(Path.Nifti.(Task), filesep, 'meanf_', Task, '_', SubjectName, '_001.nii');
matlabbatch{1, 1}.spm.spatial.coreg.estwrite.source{1, 1}=strcat(Path.Nifti.(Task), filesep, 's_', SubjectName, '.nii');


spm_jobman('run', matlabbatch)


end


function kh_segment (SubjectName, Path, Task)
    
load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\03_Segment.mat')

cd(strcat(Path.Nifti.(Task)))

matlabbatch{1, 1}.spm.spatial.preproc.data{1, 1} = strcat(Path.Nifti.(Task), filesep, 's_', SubjectName, '.nii');

spm_jobman('run', matlabbatch)

end


function kh_smooth (SubjectName, Path, Task)


    load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\04_Smooth.mat')
    cd(strcat(Path.Nifti.(Task)))

    DirFilesTask    = dir(fullfile(Path.Nifti.(Task), 'rf*.nii')); 
    matlabbatch{1, 1}.spm.spatial.smooth.fwhm =[4 4 4];

     for j=1:length(DirFilesTask)
         matlabbatch{1, 1}.spm.spatial.smooth.data{j, 1}=strcat(Path.Nifti.(Task), filesep, DirFilesTask(j,1).name, ',1')
     end

    spm_jobman('run', matlabbatch)


end


function kh_modelspecification (SubjectName, Path, Task) 

 load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\05_Modelspecification.mat')
 cd(strcat(Path.Nifti.(Task)))

 matlabbatch{1, 1}.spm.stats.fmri_spec.dir{1, 1} = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep);

 DirFilesTask    = dir(fullfile(Path.Nifti.(Task), 'srf*.nii')); 
 

     for j=1:length(DirFilesTask)
         matlabbatch{1, 1}.spm.stats.fmri_spec.sess.scans{j, 1}=strcat(Path.Nifti.(Task), filesep, DirFilesTask(j,1).name, ',1')
     end

matlabbatch{1, 1}.spm.stats.fmri_spec.sess.cond(1, 1).onset = [ 1; 21; 41; 61; 81; 101; 121 ] ;
matlabbatch{1, 1}.spm.stats.fmri_spec.sess.cond(1, 2).onset =  [ 11; 31; 51; 71; 91; 111] ;

matlabbatch{1, 1}.spm.stats.fmri_spec.sess.multi_reg = strcat('rp_f_', Task, '_', SubjectName, '_001.txt')
    
spm_jobman('run', matlabbatch)



end


function kh_estimation (SubjectName, Path, Task)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\06_Modelestimation.mat')

PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep);
cd(PathStatistics)

matlabbatch{1, 1}.spm.stats.fmri_est.spmmat{1, 1} = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep, 'SPM.mat');


spm_jobman('run', matlabbatch)


end


function kh_contrast_manager (SubjectName, Path, Task)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\07_Contrast_Manager.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep);
cd(PathStatistics)

matlabbatch{1, 1}.spm.stats.con.spmmat{1, 1}  = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep, 'SPM.mat');

spm_jobman('run', matlabbatch)


end


function  kh_Results_Report (SubjectName, Path, Task )

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\08_Results_Report.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep);
cd(PathStatistics)

matlabbatch{1, 1}.spm.stats.results.spmmat{1, 1} = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep, 'SPM.mat');
matlabbatch{1, 1}.spm.stats.results.conspec.extent = 5;
spm_jobman('run', matlabbatch)



end


function kh_normalizeTmap (SubjectName, Path, Task)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\09_NormalizeTmap.mat')
PathStatistics = strcat(Path.Subject, filesep, 'fMRI', filesep, 'statistics', filesep, Task, filesep);
cd(PathStatistics)

matlabbatch{1, 1}.spm.spatial.normalise.write.subj.matname{1, 1} = strcat( Path.Subject, filesep, 'fMRI', filesep, 'nifti', filesep, Task, filesep, 's_', SubjectName, '_seg_sn.mat');
% matlabbatch{1, 1}.spm.spatial.normalise.write.subj.resample{1, 1}= strcat(PathStatistics, 'spmT_0001.img,1');
matlabbatch{1, 1}.spm.spatial.normalise.write.subj.resample{1, 1}= strcat(PathStatistics, 'con_0001.img,1');

spm_jobman('run', matlabbatch)


end

function kh_rendersurface (SubjectName, Path, Task, TaskFullName)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\11_SurfaceRendering.mat')
cd(strcat(Path.Nifti.(Task)))

matlabbatch{1, 1}.spm.util.spm_surf.data{1, 1} = strcat('c1s_', SubjectName, '.nii,1')
matlabbatch{1, 1}.spm.util.spm_surf.data{2, 1} = strcat('c2s_', SubjectName, '.nii,1')

spm_jobman('run', matlabbatch)

end


function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end