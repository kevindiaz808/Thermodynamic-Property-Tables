classdef tpt
    % tpt (thermodynamic property tables) package based on Cengel tables
    % 
    % Usage:
    %   h = tpt.getProps('h', 'A6', 'P', 1.0, 'T', 300)
    %   Tsat = tpt.getProps('T', 'A4', 'P', 101.3)
    %
    % Methods:
    %   getProps  - Main property lookup function
    %   install   - Install package to MATLAB path
    %   uninstall - Remove package from MATLAB path
    %   update    - Check for updates
    
    methods (Static)
        function varargout = getProps(varargin)
            % Main property lookup function
            [varargout{1:nargout}] = tpt.getProps(varargin{:});
        end
        
        function install()
            % Install the package
            tpt.install();
        end
        
        function uninstall()
            % Uninstall the package
            tpt.uninstall();
        end
        
        function update()
            % Check for updates
            tpt.update();
        end
    end
end