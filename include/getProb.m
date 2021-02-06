function PROPERTIES = getProb()
%%GETPROB 
%  INPUT:
%     -   :
%  OUTPUT:
%     -   functionPROPERTIES:

%% General
% Time
PROPERTIES.deltaTime    	= 5e-4; %time step
PROPERTIES.timeTotal       = 10; %time in seconds           
PROPERTIES.time            = 0:PROPERTIES.deltaTime:PROPERTIES.timeTotal ;
PROPERTIES.nTimeSteps      = length(PROPERTIES.time);

% Excitation
PROPERTIES.amplitudeExcitation = 1e3;	
PROPERTIES.frequencyExcitation = 1e2; 












end
