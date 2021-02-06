function STRUCTURE = getStructure()
%%GETSTRUCTURE 
%  INPUT:
%     -    :
%  OUTPUT:
%     -   functionSTRUCTURE:

% Geometry
STRUCTURE.length              = 10;
STRUCTURE.thickness           = 0.2;

%Properties
STRUCTURE.youngsModulus     	= 7.24e10;  
STRUCTURE.density             = 2770;     
STRUCTURE.areaCrossSection  	= 0.04;    	
STRUCTURE.areaMomentIntertia  = 1.33e-4; 	

%Elements 
STRUCTURE.Elements.ElementType =   "Beam";
STRUCTURE.Elements.nElementsX =     3;

% Rayleigh Damping
STRUCTURE.Rayleigh.alpha = 0.01;
STRUCTURE.Rayleigh.beta = 0.01; 
end

