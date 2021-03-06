
function fmri_for_all_subjects  

    PatientFolder = 'D:\kirsten_thesis\data\patients\';
%     ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    
    fmriSelectSubjects (PatientFolder)
%     fmriSelectSubjects (ControlsFolder)
    
end


function fmriSelectSubjects (Mainfolder)

    List = dir( Mainfolder );

 for i = 1 : size (List)
      if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
          SubjectPath = strcat(Mainfolder, List(i,1).name) ;
          SubjectName = List(i,1).name  
          
          [Path] = MakePath(SubjectPath, SubjectName)
          CopyStructImage (SubjectName, Path, 'VG')
          
      end
 end
 
end

function CopyStructImage(SubjectName, Path, Task)

%     NewFolder = strcat(Path.Nifti.MRI, filesep, 'CopyOfAnatomical' ) ;
%     if ~exist(NewFolder) 
%     mkdir (NewFolder)
%     end
    
    OldFile = strcat(Path.Nifti.MRI, filesep, 'CopyOfAnatomical', filesep, 's_', SubjectName, '.nii')
    NewFolder = strcat (Path.Nifti.(Task), filesep)
    
   copyfile(OldFile, NewFolder)

    
end 
     
function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.MRI = strcat (SubjectPath, filesep, 'MRI') ;
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end

