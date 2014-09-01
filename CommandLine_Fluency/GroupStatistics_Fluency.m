
function fmri_for_all_subjects  

    
    ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    fmriSelectSubjects (ControlsFolder)
    
end



function fmriSelectSubjects (Mainfolder)

    List = dir( Mainfolder );
    Files =[];
    
    for i = 3 : size (List)
        if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
            SubjectPath = strcat(Mainfolder, List(i,1).name) ;
            SubjectName = List(i,1).name
            
            [Path] = MakePath(SubjectPath, SubjectName)
            [Files]=getFiles (SubjectName, Path, 'Fluency', i, Files)
            
        end
    end
 
    kh_groupstatistics (SubjectName, Path, 'Fluency', Files)
    
    
     
end


function kh_groupstatistics (SubjectName, Path, Task, Files)

load ('D:\kirsten_thesis\programs\Matlab\scripts_thesis\fMRI\CommandLine_BatchFiles\Groupanalysis_Controls.mat')
    matlabbatch{1, 1}.spm.stats.factorial_design.dir{1, 1} =  strcat('D:\kirsten_thesis\data\all\Results_controls\fMRI\', Task);
   
    for i= 1:length(Files)
    matlabbatch{1, 1}.spm.stats.factorial_design.des.t1.scans=Files;
    end
    
    spm_jobman('run', matlabbatch)
end



function  [Files]=getFiles (SubjectName, Path, Task, i, Files)

Files{i-2,1}=strcat('D:\kirsten_thesis\data\controls\', SubjectName,'\fMRI\statistics\', Task, '\wcon_0001.img,1');


end




function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end