
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
            Path.Nifti.MRI = strcat (SubjectPath, filesep, 'fMRI\MRI_nullpunktkorrigiert') ;
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
        
 end

function fmriMain (SubjectName, Path)

 % Reject all other patients but this one:
        if ( 0 == strcmp (Path.Subject, 'D:\kirsten_thesis\data\controls\zzz_ca'))
            return;
        end
 
kh_realign_reslice (Path.Nifti.VG, SubjectName, 'VG')
% kh_realign_reslice (Path.Nifti.Fluency, SubjectName, 'Fluency')

% kh_coregistration (Path.Nifti.VG, Path.Nifti.MRI, SubjectName, 'VG')

end