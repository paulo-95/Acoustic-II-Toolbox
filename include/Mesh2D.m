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
        localnNodeX;
        localnNodeZ;
        nNodesZ;
        nNodes;
        nDofNode;
        nodeCoordinates;
        
        zDiscretizationDisp
        nodeCoordinatesDisp;
        
        local_connect;
        connectivityElementsDOF;
        
        sizeX;    %% Geometric properties
        sizeZ;
        deltaX;
        deltaZ;
        
        xDiscretization;
        zDiscretization;
        xCoordinate;
        yCoordinate;
        zCoordinate;

    end
    
    methods
        function obj = Mesh2D(Domain)
            %MESH Construct an instance of this class
            %   Detailed explanation goes here
            
            obj.elementType = Domain.Elements.ElementType;
            obj.nElementsX = Domain.Elements.nElementsX;
            
            if (isempty(Domain.Elements.nElementsZ))
                 obj.nElementsZ = 1;
            else
                obj.nElementsZ = Domain.Elements.nElementsZ;
            end
            obj.localnNodeX = Domain.Elements.localnNodeX;
            obj.localnNodeZ = Domain.Elements.localnNodeZ;
            obj.ndofElement = Domain.Elements.DOFperElement;
            obj.nDofNode = Domain.Elements.DOFperNode;
            obj.sizeX = Domain.length;
            
            if (isempty(Domain.height))
                obj.sizeZ = 1;
            else
                obj.sizeZ = Domain.height;
            end
            
            obj.xCoordinate = Domain.position(1);
            obj.yCoordinate = Domain.position(2);
            obj.zCoordinate = Domain.position(3);
            
            obj.local_connect = Domain.Elements.local_connect;
            obj = setProperties(obj); %Call setter method
        
            obj = setNodeCoordinates(obj);
            %obj.connectivityNodesDOF = getConnectivityNode(obj);          
            obj.connectivityElementsDOF = getConnectivityElement(obj);
        end 
        
        function obj = setProperties(obj)
            obj.nElements = obj.nElementsZ*obj.nElementsX;

            obj.nNodesX =  obj.localnNodeX * obj.nElementsX;
            obj.nNodesZ =  obj.localnNodeZ * obj.nElementsZ;
            obj.nNodes = obj.nElements * obj.ndofElement/obj.nDofNode;

            obj.deltaX = obj.sizeX/obj.nElementsX;
            obj.deltaZ = obj.sizeZ/obj.nElementsZ;
        end
        
        function obj = setNodeCoordinates(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           
            obj.xDiscretization = 0:obj.deltaX:obj.deltaX*obj.nElementsX;
            if (obj.deltaZ ==1 && obj.ndofElement/obj.nDofNode==2)
                obj.zDiscretization = obj.deltaZ/2;
                obj.zDiscretizationDisp = 0:obj.deltaZ:obj.deltaZ*obj.nElementsZ;
                obj.nodeCoordinatesDisp = cat(3,meshgrid(obj.xDiscretization+obj.xCoordinate...
                    , obj.zDiscretizationDisp),0*meshgrid(obj.xDiscretization,...
                    obj.zDiscretizationDisp+obj.zCoordinate),...
                 meshgrid(obj.zDiscretizationDisp+obj.zCoordinate, obj.xDiscretization)');
            else
                obj.zDiscretization = 0:obj.deltaZ:obj.deltaZ*obj.nElementsZ;
            end
                    
            obj.nodeCoordinates = cat(3,meshgrid(obj.xDiscretization+obj.xCoordinate, obj.zDiscretization+obj.zCoordinate),....
                0*meshgrid(obj.xDiscretization, obj.zDiscretization+obj.zCoordinate),...
                meshgrid(obj.zDiscretization+obj.zCoordinate, obj.xDiscretization)');
            
        end
        
                
        function Connectivity = getConnectivityElement(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
                    
                    Connectivity = ones(obj.nElements,1) * obj.local_connect(obj.nElementsX);

                    for iElementZ = 1 : obj.nElementsZ
                        for iElementX = 1 : obj.nElementsX
                            
                            iElement = iElementX + (iElementZ-1)*obj.nElementsX;
                            Connectivity(iElement, :) = ...
                                Connectivity(iElement, :) + ...
                                (iElementX - 1)*obj.nDofNode + (iElementZ - 1)*(obj.nElementsX+1);

                        end
                    end
                    
                    
        end
        
        
        
        
        
        
    end
end

