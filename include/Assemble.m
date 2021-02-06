classdef Assemble < handle
    %ASSEMBLE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        ElementMassMatrix
        ElementStiffnessMatrix
        MassMatrix
        StiffnessMatrix
        DampingMatrix
    end

    methods
        function obj = Assemble(Domain)
            %ASSEMBLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.MassMatrix = zeros(Domain.Mesh.nNodes*Properties.nDofNode);
            
            obj.StiffnessMatrix = zeros(Mesh.nNodes*Properties.nDofNode);
        end
        
        function obj = getElementStiffness(obj)            
            %B = 1;
            %C = 2;
            
            % Acoustic
            %Ke = c^2 * Gaussian( b^t  )
            
            
            % Displacement
            %Ke = Gaussian( b^t c  b )
            
        end
        
        function obj =  getElementMass(obj)
            
        end 

        function obj = getGlobal(obj)

             for iElement = 1 : Mesh.nElements  

                 dofElement = Mesh.dofElements(iElement, :);

                 obj.MassMatrix(dofElement, dofElement) = massMatrix(dofElement, dofElement) + elementMassMatrix;
                 obj.StiffnessMatrix(dofElement, dofElement) = stiffnessMatrix(dofElement, dofElement) + elementStiffnessMatrix;
             end
        end
        
        function obj = getDampingMatrix(obj)
            obj.DampingMatrix = Properties.alpha*massMatrix + Properties.beta*stiffnessMatrix;
        end 
        
        
        function Func = intGaussian(fun)
            % fun(r,s)
            %Gausspoints
            r = 1/sqrt(3)*[-1, 1, 1, -1];
            s = 1/sqrt(3)*[-1, -1, 1, 1];

            %Gaussweights
            ar = [1, 1, 1, 1];
            as = [1, 1, 1, 1];
        
            Func = zeros(size(fun));
            for i = 1:1:length(r)
                for j = 1:1:length(s)   
                        Func = Func + ar(i)*as(j)*fun(i,j);
                end
            end 

        end
       
    end
end

