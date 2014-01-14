
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
          fmriMain (SubjectName, Path)
          
      end
 end
 
end

     
function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.MRI = strcat (SubjectPath, filesep, 'MRI') ;
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end

function fmriMain (SubjectName, Path)

 % Reject all other patients but this one:
        if ( 1 == strcmp (Path.Subject, 'D:\kirsten_thesis\data\patients\Pat_01_13021km'))
            return;
        end
 

kh_realign_reslice (Path.Nifti.VG)
kh_realign_reslice (Path.Nifti.Fluency)

end