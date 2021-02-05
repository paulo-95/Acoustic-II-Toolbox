classdef Mesh
    %MESH Creates a Fluid or Structure Mesh
    %   Structures Mesh :  Uses a 1D Mesh with nDofNode DOF's
    %   Fluid Mesh : Uses a Quadrilateral element with 4 Nodes and 4 DOFS
    
    properties
        
        representation;
        
        length = 1;
        height = 1;
        
        Connectivity;
        nElementsX = 1;
        nElementsZ = 1;
        nElements;
        
        xCoordinates;
        zCoordinates;
        deltaX;
        deltaZ;
        
        
        nDofNode;
        nNodesX;
        nNodesZ;
        nNodes;
        
        nodeCoordinates;
        
        dofNodes;
        
    end
    
    methods
        
        function obj = Mesh(Properties)
            %%MESH
            % Constructer of Objekt
            %  INPUT:
            %     -   Properties: Of Kontinuum to Mesh
            %  OUTPUT:
            %     -   functionobj: Object of Mesh
            
            % Set Properties
            obj.representation = Properties.representation;
            
            obj.length = Properties.length;
            
            if contains(obj.representation, 'Fluid')
                obj.height = Properties.height;
            end
            
            obj.nElementsX = Properties.nElementsX;
            obj.nElementsZ = Properties.nElementsZ;
            obj.nElements  = obj.nElementsX*obj.nElementsZ;
            
            obj.nDofNode = Properties.nDofNode;
            
            
            %Call Generate Method in Constructor
            obj = generateMesh(obj);
            
        end
        
        function obj = generateMesh(obj)
            obj = setNodeCoordinates(obj);
            obj = setDofNodes(obj);
            obj = getConnectivity(obj);
        end
        
        
        function obj = setNodeCoordinates(obj)
            
            
            switch obj.representation
                case 'Fluid'
                    % Quadrilateral elements with 4 nodes and 4 dofs. Counterclockwise numbering.
                    obj.deltaX = obj.length/obj.nElementsX;
                    obj.deltaZ = obj.height/obj.nElementsZ;
                    
                    obj.xCoordinates = 0:obj.deltaX:obj.deltaX*obj.nElementsX;
                    obj.zCoordinates = 0:obj.deltaZ:obj.deltaZ*obj.nElementsZ;
                    
                    obj.nodeCoordinates = cat(3,meshgrid(obj.xCoordinates, obj.zCoordinates),....
                        0*meshgrid(obj.xCoordinates, obj.zCoordinates),...
                        meshgrid(obj.zCoordinates, obj.xCoordinates)');
                    
                    
                    obj.nNodesX = obj.nElementsX + 1;
                    obj.nNodesZ = obj.nElementsZ + 1;
                    obj.nNodes  = obj.nNodesX*obj.nNodesZ;
                    
                case 'Structure'
                    % Element with 2 nodes and 4 dofs.
                    
                    if obj.length > obj.height
                        obj.nNodesX = obj.nElementsX + 1;
                        obj.nNodesZ = 1;
                        obj.nNodes  = obj.nNodesX*obj.nNodesZ;
                        
                        obj.deltaX = obj.length/obj.nElements;
                        obj.deltaZ = 0;
                        obj.xCoordinates = 0:obj.deltaX:obj.deltaX*obj.nElements;
                        obj.zCoordinates = 0*obj.xCoordinates;
                        

                        obj.nodeCoordinates = cat(3,meshgrid(obj.xCoordinates, 1),....
                            0*meshgrid(obj.xCoordinates, 1),...
                            meshgrid(obj.zCoordinates, 1));
                        
                    else
                        obj.nNodesX = 1;
                        obj.nNodesZ = obj.nElementsZ + 1;
                        obj.nNodes  = obj.nNodesX*obj.nNodesZ;
                        
                        obj.deltaX = 0;
                        obj.deltaZ =  obj.height/obj.nElements;
                        
                        obj.zCoordinates = 0:delta:delta*obj.nElements;
                        obj.xCoordinates = 0*obj.zCoordinates;
                        
                        
                        obj.nodeCoordinates = cat(3,meshgrid(obj.xCoordinates, 1),....
                            0*meshgrid(obj.xCoordinates, 1),...
                            meshgrid(obj.zCoordinates, 1));
                    end
                    
            end
        end
        
        function obj = setDofNodes( obj)
            obj.dofNodes = ones(obj.nNodes, 1)*(1:obj.nDofNode)+ (0:obj.nDofNode:(obj.nNodes-1)*obj.nDofNode)'*ones(1, obj.nDofNode);
        end
        
        function obj = getConnectivity(obj)
            
            switch obj.representation
                case 'Structure'
                    obj.Connectivity = [obj.dofNodes(1:end-1, :)'; obj.dofNodes(2:end, :)']';
                    
                case 'Fluid'
                    % Quadrilateral elements with 4 nodes and 4 dofs. Counterclockwise numbering.
                    obj.Connectivity = ones(obj.nElements, 1)*[1, 2, obj.nNodesX + 2, obj.nNodesX + 1];
                    
                    for iElementZ = 1 : obj.nElementsZ
                        for iElementX = 1 : obj.nElementsX
                            
                            iElement = iElementX + (iElementZ-1)*obj.nElementsX;
                            obj.Connectivity(iElement, :) = ...
                                obj.Connectivity(iElement, :) + (iElementX - 1) + (iElementZ - 1)*obj.nNodesX;
                            
                        end
                    end
            end
        end
    end
end

