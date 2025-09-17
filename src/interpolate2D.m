% --- Helper function for 2-D linear interpolation ---
function prop = interpolate2D(T, x_type, x_query, y_type, y_query, desired_value)
    % Performs 2D linear interpolation on tabular data
    % T: table containing the data
    % x_type: name of the first independent variable column (e.g., 'P')
    % x_query: query value for the first variable
    % y_type: name of the second independent variable column (e.g., 'T')
    % y_query: query value for the second variable
    % desired_value: name of the dependent variable column to interpolate
    
    % Get all unique values of the first variable (e.g., pressures)
    all_x = unique(T.(x_type), 'stable');
    
    % Check if the desired x value is exactly in the table
    any(all_x == x_query)
    if any(all_x == x_query)
        % Exact x value found: simple 1-D interpolation on y
        exact_x_table = T(T.(x_type) == x_query, :);
        y_col = exact_x_table.(y_type);
        prop_col = exact_x_table.(desired_value);
        prop = interpolate1D(y_col, prop_col, y_query);
        
    else
        % x value is not exact: need 2-D interpolation
        % Find the lower and higher x values
        idx_low = find(all_x < x_query, 1, 'last');
        idx_high = find(all_x > x_query, 1, 'first');
        
        if isempty(idx_low) || isempty(idx_high)
            error('Error: %s value %g is out of table range.', x_type, x_query);
        end
        
        x_low = all_x(idx_low);
        x_high = all_x(idx_high);
        
        % Interpolate at the lower x value to get the property at the desired y
        T_lowX = T(T.(x_type) == x_low, :);
        prop_at_lowX = interpolateAtFixedX(T_lowX, y_type, y_query, desired_value);
        
        % Interpolate at the higher x value to get the property at the desired y
        T_highX = T(T.(x_type) == x_high, :);
        prop_at_highX = interpolateAtFixedX(T_highX, y_type, y_query, desired_value);
        
        % Finally, interpolate between the x values
        prop = prop_at_lowX + (prop_at_highX - prop_at_lowX) * ...
               (x_query - x_low) / (x_high - x_low);
    end
end