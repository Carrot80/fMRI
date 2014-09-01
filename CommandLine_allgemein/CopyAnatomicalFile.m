
function fmri_for_all_subjects  

    PatientFolder = 'D:\kirsten_thesis\data\patients\';
    ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    
    fmriSelectSubjects (PatientFolder)
    fmriSelectSubjects (ControlsFolder)
    
end


function fmriSelectSubjects (Mainfolder)

    List = dir( Mainfolder );

 for i = 1 : size (List)
      if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
          SubjectPath = strcat(Mainfolder, List(i,1).name) ;
          SubjectName = List(i,1).name  
          
          [Path] = MakePath(SubjectPath, SubjectName)
          CopyStructImage (SubjectName, Path)
          
      end
 end
 
end

function CopyStructImage(SubjectName, Path)

    NewFolder = strcat(Path.Nifti.MRI, filesep, 'CopyOfAnatomical' ) ;
    if ~exist(NewFolder) 
    mkdir (NewFolder)
    end
    OldFile = strcat(Path.Nifti.MRI, filesep, 's_', SubjectName, '.nii')
    NewFile = strcat (NewFolder, filesep, 's_', SubjectName, '.nii')
    
    if ~exist(NewFile)
         copyfile(OldFile, NewFile)
    end
    
end 
     
function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.MRI = strcat (SubjectPath, filesep, 'MRI') ;
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end

