classdef Mesh2D
    %MESH Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        elementType;   %%Element properties
        nElementsX;
        nElementsZ;
        nElements;
        ndofElement;
        
        nNodesX;
        nNodesZ;
        nNodes;
        nDofNode;
        nodeCoordinates;
        nodeCoordinatesDisp;
        
        connectivityElementsDOF;
        connectivityNodesDOF;
        
        sizeX;    %% Geometric properties
        sizeZ;
        deltaX;
        deltaZ;
        
        xDiscretization;
        zDiscretization;
    end
    
    methods
        function obj = Mesh2D(Domain)
            %MESH Construct an instance of this class
            %   Detailed explanation goes here
            
            obj.elementType = Domain.Elements.ElementType;
            obj.nElementsX = Domain.Elements.nElementsX;
            
            if (~isfield(Domain.Elements,'nElementsZ'))
                 obj.nElementsZ = 1;
            else
                obj.nElementsZ = Domain.Elements.nElementsZ;
            end
            
            obj.ndofElement = Domain.Elements.DOFperElement;
            obj.nDofNode = Domain.Elements.DOFperNode;
            obj.sizeX = Domain.length;
            
            if (~isfield(Domain,'height'))
                obj.sizeZ = 1;
            else
                obj.sizeZ = Domain.height;
            end
            
            
            obj = setProperties(obj); %Call setter method
        
            obj = setNodeCoordinates(obj);
            obj.connectivityNodesDOF = getConnectivityNode(obj);          
            obj.connectivityElementsDOF = getConnectivityElement(obj);
        end 
        
        function obj = setProperties(obj)
            obj.nElements = obj.nElementsZ*obj.nElementsX;

            obj.nNodesX =  (obj.ndofElement / obj.nDofNode) * obj.nElementsX;
            obj.nNodesZ =  (obj.ndofElement / obj.nDofNode) * obj.nElementsZ;
            obj.nNodes = obj.nNodesX*obj.nNodesZ;

            obj.deltaX = obj.sizeX/obj.nElementsX;
            obj.deltaZ = obj.sizeZ/obj.nElementsZ;
        end
        
        function obj = setNodeCoordinates(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           
            obj.xDiscretization = 0:obj.deltaX:obj.deltaX*obj.nElementsX;
            if (obj.deltaZ ==1 && obj.ndofElement/obj.nDofNode==2)
                obj.zDiscretization = obj.deltaZ/2;
                zDiscretizationDisp = 0:obj.deltaZ:obj.deltaZ*obj.nElementsZ;
                obj.nodeCoordinatesDisp = cat(3,meshgrid(obj.xDiscretization, zDiscretizationDisp),....
                0*meshgrid(obj.xDiscretization, zDiscretizationDisp),...
                 meshgrid(zDiscretizationDisp, obj.xDiscretization)');
            else
                obj.zDiscretization = 0:obj.deltaZ:obj.deltaZ*obj.nElementsZ;
            end
                    
            obj.nodeCoordinates = cat(3,meshgrid(obj.xDiscretization, obj.zDiscretization),....
                0*meshgrid(obj.xDiscretization, obj.zDiscretization),...
                meshgrid(obj.zDiscretization, obj.xDiscretization)');
            
        end
        
        
        function connectivityNodesDOF = getConnectivityNode(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           connectivityNodesDOF = ones(obj.nNodes, 1)*(1:obj.nDofNode)...
               +(0:obj.nDofNode:(obj.nNodes-1)*obj.nDofNode)'*ones(1, obj.nDofNode);

        end
        
                
        function Connectivity = getConnectivityElement(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here

                    Connectivity = ones(obj.nElements, 1)*[1, 2, obj.nNodesX + 2, obj.nNodesX + 1];
                    
                    for iElementZ = 1 : obj.nElementsZ
                        for iElementX = 1 : obj.nElementsX
                            
                            iElement = iElementX + (iElementZ-1)*obj.nElementsX;
                            Connectivity(iElement, :) = ...
                                Connectivity(iElement, :) + (iElementX - 1) + (iElementZ - 1)*obj.nNodesX;
                            
                        end
                    end
                    
                    
        end
        
        
        
        
    end
end
