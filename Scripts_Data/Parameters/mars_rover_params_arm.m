%% Script to setup parameters for the rover arm 

% Copyright 2021-2024 The MathWorks, Inc

%% Arm Joint Params
Rover.Arm.ShoulderLR.D = 0.5; % N*m/(deg/s)
Rover.Arm.ShoulderUD.D = 0.5; % N*m/(deg/s)
Rover.Arm.WristUD.D    = 0.5; % N*m/(deg/s)
Rover.Arm.WristLR.D    = 0.5; % N*m/(deg/s)
Rover.Arm.Elbow.D      = 0.5; % N*m/(deg/s)
Rover.Arm.EEUD.D       = 0.5; % N*m/(deg/s)
%D2 = 0.5;

%% Arm PID Gains
Control.Arm.Kp = 200;
Control.Arm.Ki = 50;
Control.Arm.Kd = 5;
Control.Arm.N  = 100;

%% Arm Assembly Params
%============= RigidTransforms =============%
%{
HomePos.R = ...
    [1.0000         0         0
         0    1.0000         0
         0         0    1.0000];
HomePos.T = [0.0042    0.1525   -0.0249];
%}

Rover.Arm.Wrist_Shaft_R = 5; %cm

Rover.Arm.Link1.translation = [-15000 12000 3250];  % mm
Rover.Arm.Link1.angle = 0;  % rad
Rover.Arm.Link1.axis = [0 0 0];

Rover.Arm.Link2(1).translation = [-83300 -7627 -3250];  % mm
Rover.Arm.Link2(1).angle = 0;  % rad
Rover.Arm.Link2(1).axis = [0 0 0];


Rover.Arm.Link2(2).translation = [-15000 -7627 750];  % mm
Rover.Arm.Link2(2).angle = pi;  % rad
Rover.Arm.Link2(2).axis = [1 0 0];


Rover.Arm.Link3(1).translation = [-18700 -7627 8750];  % mm
Rover.Arm.Link3(1).angle = 0;  % rad
Rover.Arm.Link3(1).axis = [0.091717735705432957 -0.99578504555806036 -5.8733215973969995e-18];

Rover.Arm.Link3(2).translation = [-83300 -7627 4750];  % mm
Rover.Arm.Link3(2).angle = 0;  % rad
Rover.Arm.Link3(2).axis = [0 0 0];

%% Arm initial assembly angle
arm_q0 = [-2.3554 -125.9144   49.8193 -175.7336  177.6446 180.0000];

%% Tip
Rover.Arm.Tip.lim.k     = 1e4;  % N/m
Rover.Arm.Tip.lim.d     = 1e3;  % N/(m/s)
Rover.Arm.Tip.lim.w     = 1e-3; % m
Rover.Arm.Tip.lim.bound = 0.01; % m

%% Storage
Rover.Arm.Storage.lim.bound = 0.01; % m
Rover.Arm.Storage.lim.k     = 1e4;  % N/m
Rover.Arm.Storage.lim.d     = 1e3;  % N/(m/s)
Rover.Arm.Storage.lim.w     = 1e-3; % m


