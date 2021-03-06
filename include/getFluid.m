function FLUID = getFluid(STRUCTURE)
%%GETFLUID 
%  INPUT:
%     -   :
%  OUTPUT:
%     -   FLUID:

FLUID.objective = 'Acoustics';

% Geometry
FLUID.length       = STRUCTURE.length;
FLUID.height       = 4;
FLUID.thickness     = STRUCTURE.thickness;

%Properties
FLUID.soundSpeed   = 340;
FLUID.density      = 1.21;

%Elements
FLUID.Elements.ElementType =   "Quadrilateral";
FLUID.Elements.nElementsX  	= STRUCTURE.Elements.nElementsX;
FLUID.Elements.nElementsZ    = 2;
FLUID.Elements.IntegrationOrder = 2;

end

