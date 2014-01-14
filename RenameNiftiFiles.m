% Umbenennen von niftis


function fmri_for_all_subjects  

    PatientFolder = 'D:\kirsten_thesis\data\patients\';
    ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    
    fmriSelectSubjects (PatientFolder)
%     fmriSelectSubjects (ControlsFolder)
    
end


function fmriSelectSubjects (Mainfolder)
    
    List = dir( Mainfolder );
    
    for i = 1 : size (List)
        if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..'))
            PathVG = strcat ( Mainfolder, List(i,1).name, filesep, 'fMRI/nifti/Verbgeneration' )  ;
            PathFluency = strcat ( Mainfolder, List(i,1).name, filesep, 'fMRI/nifti/Fluency') ;
            RenameFiles2( strcat(Mainfolder, List(i,1).name), List(i,1).name, PathVG, 'VG'  );
            RenameFiles2( strcat(Mainfolder, List(i,1).name), List(i,1).name, PathFluency, 'Fluency'  );
        end
    end
end



function RenameFiles2 (PatientPath, PatientName, Path, Task)

 % Reject all other patients but this one:
%         if ( 0 == strcmp (PatientPath, 'D:\kirsten_thesis\data\patients\Pat_01_13021km'))
%             return;
%         end

   
    % Get the selected file data :
    
    dirData = dir(fullfile(Path, filesep,'f*.nii'));
    
    fn = strcat(Path, filesep, 'f_', Task, '_', PatientName, '_001.nii')
    
    if exist (fn, 'file')
        return
    end
    
            for i = 1 : length(dirData)
                
               num = i ;
               NewName = sprintf ('f_%s_%s_%03.0f.nii',  Task, PatientName, num ) ; 
               movefile( strcat(Path, filesep, dirData(i,1).name), strcat ( Path, filesep, NewName));    
           end

end