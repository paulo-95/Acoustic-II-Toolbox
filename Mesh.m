classdef Mesh
    %MESH Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        length;
        nElements;
    end
    
    methods
        function obj = Mesh(inputArg1,inputArg2)
            %MESH Construct an instance of this class
            %   Detailed explanation goes here
            obj.length = inputArg1;
            obj.nElements = inputArg2;
        end
        
        function [ obj ] = getMesh( PropertiesStructure )
            % Mesh = getMeshStructure(PropertiesStructure)

            obj = obj.initializeMesh(PropertiesStructure);
            obj = obj.setNodeCoordinates(obj, PropertiesStructure.length);
            obj = obj.setDofNodes(obj, PropertiesStructure.nDofNode); 
            obj = obj.setDofElements(obj);
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

