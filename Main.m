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


%% Input

% Load Properties and Settings 
PROPERTIES = getProb();

% Create PlaceHolder for Domains
STRUCTURE = PROPERTIES.STRUCTURE;
FLUID = PROPERTIES.FLUID;

%Load Elements
STRUCTURE.Elements = getElements(STRUCTURE);
FLUID.Elements = getElements(FLUID);


%% Mesh Continuum
STRUCTURE.Mesh = Mesh2D(STRUCTURE);
FLUID.Mesh = Mesh2D(FLUID);

%% Assemble System
%STRUCTURE.System = Assemble(STRUCTURE);
%FLUID.System = Assemble(FLUID);


%% Coupling
%CoupledSystem = Couple(STRUCTURE,FLUID);

%% Time Integration




%% Postprocessing

MeshFluidPlot = Visualize(FLUID.Mesh);
MeshStructurePlot = Visualize(STRUCTURE.Mesh);



