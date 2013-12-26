
function ImageCheckMain  

    PatientFolder = 'L:\kirsten_thesis\data\patients\';
    ControlsFolder = 'L:\kirsten_thesis\data\controls\'
    
    ImageCheck (PatientFolder)
    ImageCheck (ControlsFolder)
    
end

function ImageCheck (MainFolder)
    
    List = dir( MainFolder );
    
    
    for i = 1 : size (List)
        if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
            SubjectPath = strcat(MainFolder, List(i,1).name) ;
            SubjectName = List(i,1).name  ;
            
            kh_display_and_print( SubjectPath, strcat (SubjectPath, '\fMRI\nifti\Fluency\')  );
            kh_display_and_print( SubjectPath, strcat (SubjectPath, '\fMRI\nifti\Verbgeneration\')  );
            kh_display_and_print( SubjectPath, strcat (SubjectPath, '\MRI\')  );
        end
    end
    
end


  function kh_display_and_print(SubjectPath, TaskPath)

    DirFilesTask = dir(fullfile(TaskPath, '*.nii')); 
    dir_files       = dir(fullfile(TaskPath,'*.nii' ));
    
    if exist (strcat(TaskPath, 'ImageCheck.ps'), 'file')
       return
    end
    
    fprintf('printing to %s \n', TaskPath);
    
    for i= 1:length(dir_files)
        files{i} = dir_files(i).name
    end
    
    files = files'
       
    for i=1:length(files)
        f{i} = [ strcat(TaskPath) files{i,1}]
    end
    
    f=f'
    
    fileName = [TaskPath, 'ImageCheck']
    for i=1:10:numel(f)
        spm_check_registration(char(f{i:min(i+9,numel(f))}));
        spm_print(fileName);
    end
    
 end
  