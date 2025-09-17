% update.m
function update(forceDownload)
    % tpt.UPDATE Check for and download new tables from GitHub
    %
    % Usage:
    %   tpt.update()        % Check for updates
    %   tpt.update(true)    % Force re-download all tables
    
    if nargin < 1
        forceDownload = false;
    end
    
    fprintf('TPT Update Check...\n');
    
    % GitHub repository details
    repo_owner = 'kevindiaz808';
    repo_name = 'Thermodynamic-Property-Tables';
    branch = 'main';
    tables_folder = 'tables';
    
    % Get local package path
    package_path = fileparts(mfilename('fullpath'));
    local_tables_path = fullfile(package_path, 'tables');
    
    try
        % Check GitHub for available tables
        fprintf('Connecting to GitHub...\n');
        
        % GitHub API to list files in tables folder
        api_url = sprintf('https://api.github.com/repos/%s/%s/contents/%s', ...
                         repo_owner, repo_name, tables_folder);
        
        % Get file list from GitHub
        options = weboptions('Timeout', 30);
        file_list = webread(api_url, options);
        
        % Create tables directory if it doesn't exist
        if ~exist(local_tables_path, 'dir')
            mkdir(local_tables_path);
        end
        
        % Download new/updated tables
        downloaded_count = 0;
        for i = 1:length(file_list)
            file_info = file_list(i);
            if ~strcmp(file_info.type, 'file') || ~endsWith(file_info.name, '.txt')
                continue;
            end
            
            local_file = fullfile(local_tables_path, file_info.name);
            needs_download = forceDownload || ~exist(local_file, 'file');
            
            if ~needs_download
                % Check if file has been updated
                local_file_info = dir(local_file);
                local_date = datetime(local_file_info.date, 'InputFormat', 'dd-MMM-yyyy HH:mm:ss');
                github_date = datetime(file_info.last_modified, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ssXXX');
                
                if github_date > local_date
                    needs_download = true;
                    fprintf('Update available: %s\n', file_info.name);
                end
            end
            
            if needs_download
                fprintf('Downloading: %s...\n', file_info.name);
                
                % Download the file
                download_url = file_info.download_url;
                websave(local_file, download_url, options);
                
                downloaded_count = downloaded_count + 1;
            end
        end
        
        if downloaded_count > 0
            fprintf('Successfully downloaded %d table(s)\n', downloaded_count);
            fprintf('Update complete! New tables are available for use.\n');
        else
            fprintf('All tables are up to date!\n');
        end
        
        % Update version file
        update_version_file(package_path);
        
    catch ME
        fprintf('Update failed: %s\n', ME.message);
        fprintf('You can manually download tables from:\n');
        fprintf('https://github.com/%s/%s/tree/%s/%s\n', ...
                repo_owner, repo_name, branch, tables_folder);
    end
end

function update_version_file(package_path)
    % Update version file with current date
    version_file = fullfile(package_path, 'version.txt');
    current_date = datestr(now, 'yyyy-mm-dd HH:MM:SS');
    fid = fopen(version_file, 'w');
    fprintf(fid, 'tpt Tables\n');
    fprintf(fid, 'Last update: %s\n', current_date);
    fprintf(fid, 'Source: https://github.com/kevindiaz808/Thermodynamic-Property-Tables\n');
    fclose(fid);
end