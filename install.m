% install.m
function install()
    % tpt.INSTALL Install the package and download initial tables
    
    fprintf('Installing Thermodyanmic-Property-Tables package...\n');
    
    % Get current package location
    package_path = fileparts(mfilename('fullpath'));
    
    % Add package to MATLAB path
    addpath(package_path);
    addpath(fullfile(package_path, 'tables'));
    
    % Save path for future sessions
    savepath();
    
    % Create tables directory
    local_tables_path = fullfile(package_path, 'tables');
    if ~exist(local_tables_path, 'dir')
        mkdir(local_tables_path);
    end
    
    % Download initial tables
    fprintf('Downloading thermodynamic tables...\n');
    try
        tpt.update(true); % Force download all tables
    catch
        fprintf('Automatic download failed. Please manually add table files to:\n');
        fprintf('%s\n', local_tables_path);
        fprintf('You can download tables from GitHub and place them in this folder.\n');
    end
    
    fprintf('Thermodynamic property tables successfully installed!\n');
    fprintf('Use: getProps(''h'', ''A6'', ''P'', 1.0, ''T'', 300)\n');
end