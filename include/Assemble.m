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
        J;
        B_sym;
        C;
        vars;
        r;
        s;
        ar;
        as;
        nIntegrationPoints;
        thickness;
        crossArea;
    end

    methods
        function obj = Assemble(Domain)
            %ASSEMBLE Construct an instance of this class
            %   Detailed explanation goes here
            obj.ElementMassMatrix = zeros(Domain.Elements.DOFperElement);
            obj.ElementStiffnessMatrix = zeros(Domain.Elements.DOFperElement);
            
            obj.MassMatrix = zeros(Domain.Mesh.connectivityElementsDOF(end:end));
            obj.StiffnessMatrix = zeros(Domain.Mesh.connectivityElementsDOF(end:end));
            
            obj.thickness = Domain.thickness;
          %%%%Check if is field   if()
                obj.crossArea = Domain.areaCrossSection;
            end
            
            obj =  setGaussian(obj,Domain);
            obj = setShapeFunctions(obj,Domain);
            obj.J = getJacobian(obj,Domain);
            obj.C = Domain.Elements.MaterialMatrixC;
            

            obj. ElementStiffnessMatrix = getElementStiffness(obj,Domain);
            obj. ElementMassMatrix = getElementMass(obj);

     
        end
        
        function obj =  setGaussian(obj,Domain)
            if (Domain.Elements.IntegrationOrder == 1)
                obj.r = 0;
                obj.s = 0;
                obj.as = 2;
                obj.ar = 2;
                obj.nIntegrationPoints = 1;
            else
                if (Domain.Elements.IntegrationOrder == 2)
                obj.r = 1/sqrt(3)*[-1, 1, 1, -1];
                obj.s = 1/sqrt(3)*[-1, -1, 1, 1];
                obj.as = 1;
                obj.ar = 1;
                obj.nIntegrationPoints = 4;
            else
                warning('The chosen Integration Order is not implemented yet Please use Integration Order 1 or 2')
                end
            end
            
        end
        
        function obj = setShapeFunctions(obj,Domain)
            obj.N_sym = Domain.Elements.ShapeFunktions;
            obj.vars = Domain.Elements.Syms;
            obj.B_sym = jacobian(obj.N_sym,obj.vars)';

        end 
        
        function J = getJacobian(obj,Domain)
            % Jacobi matrix
                J = [Domain.Mesh.deltaX/1, 0;
                    0, Domain.Mesh.deltaZ/1];
        end 
        
        
        function Ke = getElementStiffness(obj,Domain)     
             switch Domain.objective
                case 'Displacement'
                    func = matlabFunction(obj.B_sym'*obj.C*obj.B_sym*det(obj.J));
                case 'Acoustics'
                    func = matlabFunction(Domain.soundSpeed^2*obj.B_sym'*obj.B_sym*det(obj.J));
            end       
             Ke = intGaussian(func,obj);  
        end
        
        function Me =  getElementMass(obj)
                    func =  matlabFunction(obj.N_sym'*obj.N_sym*det(obj.J));
                    Me = intGaussian(func,obj);  
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
        
        
        function Func = intGaussian(fun,obj)
            % fun(r,s)
            %Gausspoints
            
            Func = zeros(size(obj.ElementMassMatrix));
            
            if (length(obj.vars)==1)
                 for i = 1:1:length(obj.r)
                     Func = Func + obj.ar*fun(obj.r(i))*obj.crossArea;
                 end 
            else
                for i = 1:1:length(obj.r)
                    for j = 1:1:length(obj.s)
                            %if nargin
                            Func = Func + obj.ar*obj.as*fun(obj.r(i),obj.s(j))*obj.thickness;
                    end
                end 
                
            end 

        end
       
    end
end

