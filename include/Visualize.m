classdef Visualize
    %VISUALIZE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Visualize(Mesh)
            %VISUALIZE Construct an instance of this class
            %   Detailed explanation goes here
            
            figure
            hold on
            

            % Plot Mesh
            if(size(Mesh.nodeCoordinates,1)==1)
                Coordinates = Mesh.nodeCoordinatesDisp;
            else
                Coordinates = Mesh.nodeCoordinates;
            end
        
            mesh(Coordinates(:,:,1),Coordinates(:,:,2),Coordinates(:,:,3));

            % Print Element Numbers% 
            % Element numbers.
            X = Coordinates(1:end-1,1:end-1,1);
            Y = Coordinates(1:end-1,1:end-1,2);
            Z = Coordinates(1:end-1,1:end-1,3);
            X = X';   
            Y = 0*Y;
            Z = Z';
            string = mat2cell(num2str((1:Mesh.nElements)'), ones(Mesh.nElements,1));
            text(X(:) + 0.5*Mesh.deltaX, Y(:), Z(:)+0.5*Mesh.deltaZ, string)

            % Plot Nodes
            plot3(Mesh.nodeCoordinates(:,:,1),Mesh.nodeCoordinates(:,:,2),Mesh.nodeCoordinates(:,:,3), 'o')
            view(180,0)
        end     
    end
end

