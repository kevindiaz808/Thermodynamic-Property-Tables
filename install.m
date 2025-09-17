function install()
    % Installation Script
    fprintf('Installing Thermodyanic Property Tables package...\n');
    
    % Get current package location
    package_path = fileparts(mfilename('fullpath'));
    
    % Add package to MATLAB path
    addpath(package_path);
    addpath(fullfile(package_path, 'tables'));
    
    % Save path for future sessions
    savepath();
    
    fprintf('Thermodyanic Property Tables successfully installed!\n');
    fprintf('Use: getProps(''h'', ''A6'', ''P'', 1.0, ''T'', 300)\n');
end