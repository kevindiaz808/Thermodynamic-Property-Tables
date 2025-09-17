function prop = getProps(desired_value, desired_table, varargin)
    % Returns the desired value using the given table and input parameters.
    % For 1-parameter tables (saturation): getProps('h', 'A4', 'T', 50)
    % For 2-parameter tables (superheated): getProps('h', 'A6', 'P', 10, 'T', 500)

    % Add package path to access tables
    tables_path = fullfile(fileparts(mfilename('fullpath')), 'tables');
    
    % Check if table exists
    table_file = fullfile(tables_path, sprintf('Table%s.txt', desired_table));
    
    if ~exist(table_file, 'file')
        % Table not found - offer to update
        fprintf('Table %s not found locally.\n', desired_table);
        answer = input('Would you like to check for updates? (y/n): ', 's');
        
        if lower(answer(1)) == 'y'
            update();
            
            % Check again after update
            if ~exist(table_file, 'file')
                error('Table %s not available. Please check GitHub for available tables.', desired_table);
            end
        else
            error('Table %s not found. Use tpt.update() to download available tables.', desired_table);
        end
    end
    % Read the given table from package
    Tname = fullfile(tables_path, sprintf('Table%s.txt', desired_table));
    T = readtable(Tname);

    % Check if this is a 2-parameter query
    isTwoParam = (nargin > 4) && (nargin == 6); % e.g., 6 total inputs

    % --- Handle 1-Parameter Tables (e.g., Saturation) ---
    if ~isTwoParam
        given_type = varargin{1};
        given_value = varargin{2};
        
        given_col = T{:, given_type};
        desired_col = T{:, desired_value};
        prop = interpolate1D(given_col, desired_col, given_value);
        
    % --- Handle 2-Parameter Tables (e.g., Superheated) ---
    else
        given_type_1  = varargin{1}; % e.g., 'P'
        given_value_1 = varargin{2}; % e.g., 10 (psia)
        given_type_2  = varargin{3}; % e.g., 'T'
        given_value_2 = varargin{4}; % e.g., 500 (F)

        if (given_type_2 == 'T') & (given_value_2 == 'sat')
            T{given_value_1, given_type_2}
            %given_value_2 = first(T{:, given_type_2} == given_type_1);
        end
        
        % Use 2D interpolation 
        prop = interpolate2D(T, given_type_1, given_value_1, given_type_2, given_value_2, desired_value);
    end
end

