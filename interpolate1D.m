% --- Helper function for 1-D linear interpolation ---
function y = interpolate1D(x_data, y_data, x_query)
    % Finds y_query for x_query using linear interpolation on x_data, y_data.
    if x_query < min(x_data) || x_query > max(x_data)
        error('Error: Query value %g is out of data range [%g, %g].',...
              x_query, min(x_data), max(x_data));
    end
    % Find indices for interpolation
    lower_idx = find(x_data <= x_query, 1, 'last');
    upper_idx = find(x_data >= x_query, 1, 'first');
    
    % If it's an exact match, return the value
    if x_data(lower_idx) == x_query
        y = y_data(lower_idx);
    else
        % Perform linear interpolation
        x1 = x_data(lower_idx);
        x2 = x_data(upper_idx);
        y1 = y_data(lower_idx);
        y2 = y_data(upper_idx);
        y = y1 + (y2 - y1) * (x_query - x1) / (x2 - x1);
    end
end