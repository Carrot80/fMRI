% Umbenennen von niftis

function ForAllPat
    
    PatientFolder = 'C:\Kirsten\DatenDoktorarbeit\Patienten\' ;
    PatientList = dir( PatientFolder );
    VolunteerFolder = 'C:\Kirsten\DatenDoktorarbeit\Kontrollen\';
    VolunteerList = dir( VolunteerFolder );
    
    for i = 1 : size (VolunteerList)
        if ( 0 == strcmp( VolunteerList(i,1).name, '.') && 0 == strcmp( VolunteerList(i,1).name, '..'))
            RenameFiles2( strcat(VolunteerFolder, VolunteerList(i,1).name), VolunteerList(i,1).name  );
        end
    end
end



function RenameFiles2 (PatientPath, PatientName)

 % Reject all other patients but this one:
        if ( 0 == strcmp (PatientPath, 'C:\Kirsten\DatenDoktorarbeit\Kontrollen\zzz_ca_Achtermann'))
            return;
        end

    PathVerbGen = strcat (PatientPath, '\', 'fMRI\nifti', '\', 'test')      
          % Get the selected file data
   
    dirData = dir(PathVerbGen);
           
            for i = 1 : length(dirData)
               if 0 == strcmp (dirData(i,1).name, '.') && 0 == strcmp (dirData(i,1).name, '..')
               FileName = dirData(i,1).name ;
               num = i-2 ;
               NewName = sprintf ('f_Verbgen_%s_%03.0f.nii',  PatientName, num ) ; 
               movefile(dirData(i,1).name, NewName);        % Rename the file
               end
           end

end