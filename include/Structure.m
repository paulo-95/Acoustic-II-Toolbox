classdef Structure < Domain
    %STRUCTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        youngsModulus;
        areaCrossSection;    	
        areaMomentIntertia; 	
        mass;
        Rayleigh =  struct('alpha',[],'beta',[]);
    end
    
    methods
        function obj = Structure(Properties)
            %STRUCTURE Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@Domain(Properties);
            obj.youngsModulus = Properties.youngsModulus;
            obj.areaCrossSection = Properties.areaCrossSection;
            obj.Rayleigh = Properties.Rayleigh;
            obj = setProperties(obj);
        end
        
        function obj = setProperties(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.mass = obj.areaCrossSection*obj.density; % mass per unit area

        end
    end
end

