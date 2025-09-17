% manual_update.m
function manual_update()
    % Instructions for manual table updates
    
    fprintf('Manual Table Update Instructions:\n');
    fprintf('1. Download new table files from GitHub:\n');
    fprintf('   https://github.com/yourusername/XSteamCengel/tree/main/tables\n');
    fprintf('2. Place the .txt files in this folder:\n');
    
    package_path = fileparts(mfilename('fullpath'));
    tables_path = fullfile(package_path, 'tables');
    fprintf('   %s\n', tables_path);
    fprintf('3. Restart MATLAB or run: rehash path\n');
    
    % Open the folder for convenience
    if exist(tables_path, 'dir')
        winopen(tables_path);
    end
end