classdef Assemble < handle
    %ASSEMBLE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        ElementMassMatrix
        ElementStiffnessMatrix
        MassMatrix
        StiffnessMatrix
        DampingMatrix
        N_sym;
        N;
        B;
        C;
        vars;
        
    end

    methods
        function obj = Assemble(Domain)
            %ASSEMBLE Construct an instance of this class
            %   Detailed explanation goes here
            obj = setShapeFunctions(Domain);
            obj.J = getJacobian(obj);
            obj.C = Domain.Elements.MaterialMatrixC;
            obj.B = calculateB(obj);
            
            obj. ElementStiffnessMatrix = getElementStiffness(obj,Domain);
            obj. ElementMassMatrix = getElementMass(obj);

            obj.MassMatrix = zeros(Domain.Mesh.connectivityElementsDOF(end:end));
            obj.StiffnessMatrix = zeros(Domain.Mesh.connectivityElementsDOF(end:end));     
        end
        
        function obj = setShapeFunctions(Domain)
            obj.N_sym = Domain.Elements.ShapeFunktions;
            obj.vars = Domain.Elements.Syms;
            obj.N = matlabFunction(obj.N_sym);
        end 
        
        function J = getJacobian(obj)
            
            
        end 
        
        function B =  calculateB(obj)
            B = jacobian(obj.N_sym,obj.vars);
            B = matlabFunction(B);
        end
        
        function Ke = getElementStiffness(obj,Domain)     
             switch Domain.objective
                case 'Displacement'
                    func = obj.B'*obj.C*obj.B*det(obj.J);
                case 'Acoustics'
                    func = Domain.soundSpeed^2*obj.B'*obj.B*det(obj.J);
            end       
             Ke = intGaussian(func);  
        end
        
        function Me =  getElementMass(obj)
                    func = obj.N'*obj.N*det(obj.J);
                    Me = intGaussian(func);  
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

