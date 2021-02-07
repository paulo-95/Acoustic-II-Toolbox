classdef (Abstract) Domain < handle
    %DOMAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        density;
        length;
        thickness;
        height;
        objective;
        Elements = struct('ElementType',[],'nElementsX',[],'nElementsZ',[],'IntegrationOrder',[]);
        position = [0;0;0];
        Mesh;
        System;
    end
    
    methods
        function obj = Domain(Properties)
            %DOMAIN Construct an instance of this class
            %   Detailed explanation goes here
            obj.objective = Properties.objective;
            obj.density = Properties.density;
            obj.length = Properties.length;
            obj.thickness = Properties.thickness;
            if(isfield(Properties,'height'))
                obj.height = Properties.height;
            end 
            if(isfield(Properties.Elements,'nElementsZ'))
                obj.Elements.nElementsZ = Properties.Elements.nElementsZ;
            end
            if(isfield(Properties.Elements,'nElementsX'))
                obj.Elements.nElementsX = Properties.Elements.nElementsX;
            end
            obj.Elements.ElementType = Properties.Elements.ElementType;
            obj.Elements.IntegrationOrder = Properties.Elements.IntegrationOrder;
        end
    end
end

