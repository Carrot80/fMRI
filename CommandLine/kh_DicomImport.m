

function DicomImportMain  

    PatientFolder = 'L:\kirsten_thesis\data\patients\';
%     ControlsFolder = 'L:\kirsten_thesis\data\controls\'
    
    DicomImport (PatientFolder)
%     DicomImport (ControlsFolder)
    
end


function DicomImport(Mainfolder)
    
     List = dir( Mainfolder );
      
    for i = 1 : size (List)
        if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
            ReadDicoms( strcat(Mainfolder, List(i,1).name), List(i,1).name  );
        end
    end
end

function ReadDicoms (PatientPath, PatientName)
      
    Path.RawData = strcat(PatientPath, filesep, 'fMRI\', 'RawData');
    Path.Nifti_MRI = strcat (PatientPath, filesep, 'MRI\') ;
    Path.Nifti_Fluency = strcat (PatientPath, '\', 'fMRI\nifti\Fluency\') ;
    Path.Nifti_VG = strcat (PatientPath, filesep, 'fMRI\nifti\Verbgeneration\') ;
    
    
    
    % if files already exist, return
  
      if 2 < length(dir(Path.Nifti_VG)) && 2 < length(dir(Path.Nifti_Fluency)) % if nifti files exist in VG and Fluency dir, go to DicomImportMRI
            
                    DicomImportMRI(Path, PatientPath, PatientName)
       
   
      elseif 2 < length(dir(Path.Nifti_VG)) && 2 == length(dir(Path.Nifti_Fluency))  % if nifti files exist only for VG, import dicoms for Fluency
          
                    DicomImportFluency(Path, PatientPath, PatientName)
                    DicomImportMRI(Path, PatientPath, PatientName)
            
      elseif 2 == length(dir(Path.Nifti_VG)) && 2 < length(dir(Path.Nifti_Fluency)) % if nifti files exist only for Flueny, import dicoms for VG
          
                    DicomImportVG(Path, PatientPath, PatientName)
                    DicomImportMRI(Path, PatientPath, PatientName)
                    
      elseif 2 == length(dir(Path.Nifti_VG)) && 2 == length(dir(Path.Nifti_Fluency)) % import both if folders are empty
          
                    DicomImportFluency(Path, PatientPath, PatientName) 
                    DicomImportVG(Path, PatientPath, PatientName)
                    DicomImportMRI(Path, PatientPath, PatientName)
                        
      end   
end 


      
function DicomImportFluency(Path, PatientPath, PatientName) 

    DirRawData = dir(Path.RawData)
    DirFluency = DirRawData(4,1).name
    Path.RawData_Fluency = strcat(Path.RawData, '\', DirFluency,'\');
    
    
      if 2 == length(dir(Path.RawData_Fluency)) 
            return
      end  
    
    cd (strcat(Path.RawData, '\', DirFluency));
      
    files = spm_select('List', Path.RawData_Fluency, 'R.*') ;
    hdr = spm_dicom_headers(files) ;
    spm_dicom_convert(hdr, 'all','flat' ,'nii') ;

    movefile(strcat (Path.RawData_Fluency, 'f*.nii') ,strcat (PatientPath, '\', 'fMRI\nifti\Fluency\'))   ; 



end
    
  

function DicomImportVG(Path, PatientPath, PatientName)

    % Folder with Verbgeneration dicoms:
    
    DirRawData = dir(Path.RawData) ;
    DirVerbgen = DirRawData(3,1).name ;
    Path.RawData_VG = strcat(Path.RawData, '\', DirVerbgen,'\');
    
     if 2 == length(dir(Path.RawData_VG)) 
            return
     end  

    cd (strcat(Path.RawData, '\', DirVerbgen)); 
    
    fprintf('reading files from %s \n', PatientName);
    
    files       = spm_select('List', Path.RawData_VG, 'R.*') ;
    hdr         = spm_dicom_headers(files) ;
    spm_dicom_convert(hdr, 'all','flat' ,'nii') ;

    movefile( strcat(Path.RawData_VG, 'f*.nii') ,strcat (PatientPath, '\', 'fMRI\nifti\Verbgeneration\')); 

    
end



function DicomImportMRI(Path, PatientPath, PatientName)

    % Folder with MRI dicoms:
    
    DirRawData           = dir(Path.RawData) ;
    FolderRawData        = DirRawData(end,1).name ;
    Path.RawDataMRI      = strcat(Path.RawData, '\', FolderRawData,'\') ;
    FileNifti            = strcat ( PatientPath, filesep, 'MRI', filesep, 's_', PatientName, '.nii') ;
    
    
    if exist (FileNifti, 'file')
        return
    end
    
    fprintf('reading files from %s \n', PatientName);
    
    files = spm_select('List', Path.RawDataMRI, 'R.*') ;
    hdr = spm_dicom_headers(strcat( Path.RawDataMRI, files)) ;
    [sImages] = spm_dicom_convert(hdr, 'all','flat' ,'nii') ; 
    
    movefile( sImages.files{1,1}, strcat(Path.Nifti_MRI,'s_', PatientName, '.nii')); 

   
end
