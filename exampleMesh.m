%################################################################################
%#                          Technical Acoustic Toolbox                          #
%#                                 Example Script                               #
%#                              written by Paul Over                            #
%################################################################################

clearvars 
close all

% set plot window behavior
set(0,'DefaultFigureWindowStyle','normal') 

% add & change path
path_2_file = mfilename('fullpath');

% always change to the folder where this file is located at and add inlcude
% folder
path_2_file = path_2_file(1:end-length(mfilename));
cd(path_2_file);
addpath(genpath('include'));





% Define the Properties of the fluid domain
PropertiesFluidDomain.representation = 'Fluid';
PropertiesFluidDomain.length          = 6;
PropertiesFluidDomain.height          = 4;
PropertiesFluidDomain.nElementsX      = 3;
PropertiesFluidDomain.nElementsZ      = 4;
PropertiesFluidDomain.nDofNode        = 1;


% Create the mesh of the fluid domain
MeshFluid = Mesh(PropertiesFluidDomain);

% Define the Properties of the Structure domain
PropertiesStructure.representation = 'Structure';
PropertiesStructure.length          = 6;
PropertiesStructure.height          = 1;
PropertiesStructure.nElementsX      = 3;
PropertiesStructure.nElementsZ      = 1;  %% Because of Structural Element
PropertiesStructure.nDofNode        = 2;

MeshStructure = Mesh(PropertiesStructure);


%% To Do
% Visualize the mesh of the fluid domain
% This your task until the next exercise as well as the generation of the structural mesh
% We will discuss the solution in the next exercise

MeshFluidPlot = Visualize(MeshFluid);
MeshStructurePlot = Visualize(MeshStructure);