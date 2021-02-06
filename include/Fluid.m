classdef Fluid < Domain
    %FLUID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        soundSpeed;
    end
    
    methods
        function obj = Fluid(Properties)
            %FLUID Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@Domain(Properties);% Call Constructor of superclass
            obj.soundSpeed = Properties.soundSpeed;
        end
    end
end

