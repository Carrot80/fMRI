function display_and_print(f)
for i=1:10:numel(f)
    spm_check_registration(char(f{i:min(i+9,numel(f))}));
    spm_print;
end