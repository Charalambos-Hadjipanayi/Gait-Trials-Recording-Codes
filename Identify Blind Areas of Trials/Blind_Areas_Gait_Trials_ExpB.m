close all
clear
clc

% Add plotting functions
addpath('../../Gait Trials - MATLAB codes and data/Identify Blind Areas/Plotting Functions/');

%% Walking pathway

% Dimensions - In meters
path_length=6;
path_width=1.5;
path_height=2; %height of interest within pathway
y_offset = 1; % Offset on y-axis from radars
x_pathway=linspace(-path_width/2,path_width/2,2);
y_pathway=linspace(y_offset,y_offset+path_length,2);
z_pathway=linspace(0,path_height,2);

% Generate end points of walking pathway in 3D space
[X_1,Y_1]=meshgrid(x_pathway,y_pathway);
[Y_2,Z_1]=meshgrid(y_pathway,z_pathway);
[X_2,Z_2]=meshgrid(x_pathway,z_pathway);

% Limits for plots
x_limits = [-10 10]; y_limits = [-2 10]; z_limits = [-10 10];

%% Radar settings
% Radar height
radar_height=2;
% Separation (horizontally) from walkway center line
radar_separation = 0;
% Radar maximum range - same for all radars
max_range = 9.9;
% Beam maximum angle
beam_angle = 100;

% Radar 3D positions
radar_1_pos_3d = [-radar_separation,0,radar_height];
radar_2_pos_3d = [radar_separation,(2*y_offset)+path_length,radar_height];

% --------------------------------------------------------------------
% Horizontal angle for radars (degrees)
% theta = 40; 
% Have radars point to the center of the pathway
theta = atand(radar_separation/((path_length/2)+y_offset));
% --------------------------------------------------------------------

% --------------------------------------------------------------------
% Vertical angle (degrees)
% phi = 20; %vertical angle
% In case we want our radar to look at the center of the pathway at a
% height of 1m:
phi = atand((radar_height-1)/(y_offset + (path_length/2)));
% --------------------------------------------------------------------

%% Plotting walking pathway
% Walking pathway will be visualised as a parallelepiped in 3D space.
figure('Name','Blind areas of Radars for Gait Trials - Experiment B','NumberTitle','off')
hold on
plot_WalkingPathway(X_1,X_2,Y_1,Y_2,Z_1,Z_2,x_pathway,y_pathway,z_pathway,x_limits,y_limits,z_limits,...
                             y_offset,path_length,path_width)

% Update title of figure
title('Blind Areas for Gait Trials')
subtitle(['\theta = ' num2str(round(theta,2)) '^{\circ} and \phi = ' num2str(round(phi,2)) '^{\circ}'])

% Visualise radars and their field-of-view
plot_RadarFOV_ExpB(radar_1_pos_3d,radar_2_pos_3d,theta,phi,max_range,beam_angle,z_limits)
zlim([0 z_limits(2)])

%% Plot from top and side

% Optional - Change the axes limits:
% x_limits = [-10 10]; y_limits = [-1 10]; z_limits = [-10 10];

figure('Name','Top and Side view of Blind areas of Radars for Gait Trials - Experiment B','NumberTitle','off')

%------------------------------------------------------------------------------
% Top-view
subplot(1,2,1)
hold on
plot_WalkingPathway(X_1,X_2,Y_1,Y_2,Z_1,Z_2,x_pathway,y_pathway,z_pathway,x_limits,y_limits,z_limits,...
                             y_offset,path_length,path_width)
title('Top view')
subtitle(['\theta = ' num2str(round(theta,2)) '^{\circ}, \phi = ' num2str(round(phi,2)) '^{\circ}'])
plot_RadarFOV_ExpB(radar_1_pos_3d,radar_2_pos_3d,theta,phi,max_range,beam_angle,z_limits)
view(0,90)
zlim([0 z_limits(2)])

%------------------------------------------------------------------------------
% Side-view
subplot(1,2,2)
hold on
plot_WalkingPathway(X_1,X_2,Y_1,Y_2,Z_1,Z_2,x_pathway,y_pathway,z_pathway,x_limits,y_limits,z_limits,...
                             y_offset,path_length,path_width)
title('Side view')
subtitle(['\theta = ' num2str(round(theta,2)) '^{\circ}, \phi = ' num2str(round(phi,2)) '^{\circ}'])
plot_RadarFOV_ExpB(radar_1_pos_3d,radar_2_pos_3d,theta,phi,max_range,beam_angle,z_limits)
view(90,0)
zlim([0 z_limits(2)])

sgtitle('Blind Areas for Gait Trials - Experiment B')