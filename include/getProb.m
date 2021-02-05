function PROPERTIES = getProb()
%%GETPROB 
%  INPUT:
%     -    :
%  OUTPUT:
%     -   functionPROPERTIES:


%% STRUCTURE
% Geometry
PROPERTIES.STRUCTURE.length              = 10;
PROPERTIES.STRUCTURE.thickness           = 0.2;

%Properties
PROPERTIES.STRUCTURE.youngsModulus     	= 7.24e10;  
PROPERTIES.STRUCTURE.density             = 2770;     
PROPERTIES.STRUCTURE.areaCrossSection  	= 0.04;    	
PROPERTIES.STRUCTURE.areaMomentIntertia  = 1.33e-4; 	
PROPERTIES.STRUCTURE.mass = PROPERTIES.STRUCTURE.areaCrossSection*PROPERTIES.STRUCTURE.density; % mass per unit area

%Elements 
PROPERTIES.STRUCTURE.Elements.ElementType =   "Beam";
PROPERTIES.STRUCTURE.Elements.nElementsX =     3;


% Rayleigh Damping
PROPERTIES.STRUCTURE.Rayleigh.alpha = 0.01;
PROPERTIES.STRUCTURE.Rayleigh.beta = 0.01; 

%% Fluid
% Geometry
PROPERTIES.FLUID.length       = PROPERTIES.STRUCTURE.length;
PROPERTIES.FLUID.height       = 4;
PROPERTIES.FLUID.thickness   	= PROPERTIES.STRUCTURE.thickness;

%Properties
PROPERTIES.FLUID.soundSpeed   = 340;
PROPERTIES.FLUID.density      = 1.21;

%Elements
PROPERTIES.FLUID.Elements.ElementType =   "Quadrilateral";
PROPERTIES.FLUID.Elements.nElementsX  	= PROPERTIES.STRUCTURE.Elements.nElementsX;
PROPERTIES.FLUID.Elements.nElementsZ    = 4;


%%General
% Time
PROPERTIES.deltaTime    	= 5e-4; %time step
PROPERTIES.timeTotal       = 10; %time in seconds           
PROPERTIES.time            = 0:PROPERTIES.deltaTime:PROPERTIES.timeTotal ;
PROPERTIES.nTimeSteps      = length(PROPERTIES.time);

% Excitation
PROPERTIES.amplitudeExcitation = 1e3;	
PROPERTIES.frequencyExcitation = 1e2; 












end
