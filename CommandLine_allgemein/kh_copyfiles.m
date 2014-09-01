
function fmri_for_all_subjects  

    PatientFolder = 'D:\kirsten_thesis\data\patients\';
%     ControlsFolder = 'D:\kirsten_thesis\data\controls\';
    
    fmriSelectSubjects (PatientFolder)
%     fmriSelectSubjects (ControlsFolder)
    
end


function fmriSelectSubjects (Mainfolder)

List = dir( Mainfolder );
LI_all = [];

for i = 3 :   size (List)
    if ( 0 == strcmp( List(i,1).name, '.') && 0 == strcmp( List(i,1).name, '..') )
        SubjectPath = strcat(Mainfolder, List(i,1).name) ;
        SubjectName = List(i,1).name
        
        
        [Path] = MakePath(SubjectPath, SubjectName)
        copyfile (Path, SubjectName, 'VG')
        
    end
    
end

end

    function copyfile (Path, SubjectName, Task)
        
%     if ~exist(Path.AnatomicalNew, 'dir')
%         mkdir Path.AnatomicalNew
%     end

    File=Path.AnatomicalOld;
exist(File, 'file')

%     copyfile (File, strcat(Path.Nifti.(Task), filesep, 's_', SubjectName, '.nii'));
     copyfile (File, strcat(Path.Nifti.(Task), filesep));
   
    
    
    end
    
    function [Path] = MakePath(SubjectPath, SubjectName)
    
            Path.Subject = SubjectPath ;
            Path.RawData = strcat(SubjectPath, filesep, 'fMRI\', 'RawData');
            Path.Nifti.Fluency = strcat (SubjectPath, '\', 'fMRI\nifti\Fluency') ;
            Path.Nifti.VG = strcat (SubjectPath, filesep, 'fMRI\nifti\Verbgeneration') ;
            Path.Statistics.VG = strcat(SubjectPath, filesep, 'fMRI\statistics\Verbgeneration') ;
            Path.AnatomicalOld = strcat(SubjectPath, '\MRI\CopyOfAnatomical\', 's_', SubjectName, '.nii');
            Path.AnatomicalNew = strcat(SubjectPath, '\fMRI\MRI_nullpunktkorrigiert');
 end
