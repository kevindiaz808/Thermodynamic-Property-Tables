% --- Helper function for interpolation at fixed x value ---
function prop = interpolateAtFixedX(T_subset, y_type, y_query, desired_value)
    % Interpolates the desired property at a fixed x value (e.g., fixed pressure)
    % across the y dimension (e.g., temperature)
    y_col = T_subset.(y_type);
    prop_col = T_subset.(desired_value);
    prop = interpolate1D(y_col, prop_col, y_query);
end