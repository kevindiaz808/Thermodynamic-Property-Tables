function uninstall()
    % Uninstallation Script
    fprintf('Uninstalling Thermodyanic-Property-Tables package...\n');
    
    % Get current package location
    package_path = fileparts(mfilename('fullpath'));
    
    % Remove package from MATLAB path
    rmpath(package_path);
    rmpath(fullfile(package_path, 'tables'));
    
    % Save path for future sessions
    savepath();
    
    fprintf('Thermodyanic-Property-Tables successfully uninstalled!\n');
end