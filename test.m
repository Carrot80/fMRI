

function kh_realign_reslice (Path, SubjectName, Task)




P = spm_select('ExtList', pwd,'^f.*'); % Extlist = Extension list option


realigment_parameters = struct('quality' ,0.9, 'fwhm', 5, 'rtm', 1, 'interp', 5)
files_realigned = spm_realign(P, realigment_parameters) 

reslicing_parameters = struct( 'mask', 1 , 'mean', 1 , 'interp', 5, 'which', 2, 'prefix', 'r' ); 
spm_reslice(files_realigned, reslicing_parameters)

end
