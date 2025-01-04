%% Script to setup parameters for the rover  

% Copyright 2021-2024 The MathWorks, Inc

%% Rover Assembly Params

Rover.Chassis.Top_Frame_R =...
    [1  0  0; 0  0  1; 0 -1  0];

Rover.Chassis.Top_Frame_T = [-1.408435770788863e-09 0.360100000000000 -0.099999999882285];

Rover.Chassis.R_Frame_R =...
    [0   0   1.0
    1.0   0   0
    0   1.0   0];
Rover.Chassis.R_Frame_T = [0.500100000000000 0.170000002063840 0.100000002063841];

Rover.Chassis.L_Frame_R = ...
    [0.0  0  -1.0
    1.0   0.0  0
    0  -1.0   0.0];

Rover.Chassis.L_Frame_T = [-0.500100000000000 0.169999999356227 0.100000001576468];

Rover.Chassis.F4_Frame_R =...
    [1.0  0  0
    0   0   1.0
    0  -1.0   0];

Rover.Chassis.F4_Frame_T = [0 0 0];

Rover.DiffBar.ToChassis_R = ...
    [1.0 0   0
    0   0  -1.0
    0   1.0   0];
Rover.DiffBar.ToChassis_T = [0   0.0401 0] ;

Rover.DiffBar.F3_R = ...
    [1.0                   0                   0
    0   0  -1.0
    0   1.0   0];
Rover.DiffBar.F3_T = [-0.550000005278643  0   0.000000002311580] ;

Rover.DiffBar.F2_R = ...
    [-1.0                   0                   0
    0   0  -1.0
    0  -1.0   0];
Rover.DiffBar.F2_T = [0.549999994090071                   0   0.000000007967969] ;


Rover.RTG.R = ...
    [1.0000         0         0
    0   -0.8660    0.5000
    0   -0.5000   -0.8660 ];

Rover.RTG.T = [0.0000    0.3479   -1.0008];


Rover.RTG_Bridge.T1 = [ -0.4400    0.4987   -0.7821];
Rover.RTG_Bridge.T2 = [0.4400    0.4987   -0.7821];

Rover.ArmBase.R = ...
    [1.0000         0         0
    0    0.0000    1.0000
    0   -1.0000    0.0000];

Rover.ArmBase.T = [0.3800    0.2500    0.9800];

Rover.CameraBase.T = [-0.400 0.3200 0.6500];

% MobilityPrimaryArmR
Rover.RockerL.SRJ_R = ...
    [1.0000         0         0
    0    0.0000   -1.0000
    0    1.0000    0.0000];

Rover.RockerL.SRJ_T = [-0.5100   -0.0901    0.0600];

Rover.RockerL.DR_R =...
    [-1.0000         0         0
    0    0.0000    1.0000
    0    1.0000    0.0000];
Rover.RockerL.DR_T = [0.0000    0.0600   -0.2000];

Rover.RockerL.LFB_R = ...
    [ 1.0000         0         0
    0   -1.0000         0
    0         0   -1.0000];
Rover.RockerL.LFB_T = [0.9950   -0.1950    0.1520];

Rover.RockerL.CRJ_R = ...
    [1.0000         0         0
    0    0.0000   -1.0000
    0    1.0000    0.0000
    ];
Rover.RockerL.CRJ_T = [ -0.0000    0.1000   -0.0000];

%L
Rover.RockerR.SRJ_R = ...
    [1.0000         0         0
    0    0.0000   -1.0000
    0    1.0000    0.0000    ];

Rover.RockerR.SRJ_T = [-0.5100   -0.0901   -0.0600];

Rover.RockerR.DL_R =...
    [1.0000         0         0
    0    0.0000    1.0000
    0    -1.0000    0.0000];
Rover.RockerR.DL_T = [0.0000    0.0625    0.2000];

Rover.RockerR.RFB_R = ...
    [ 1.0000         0         0
    0   1.0000         0
    0         0   1.0000];
Rover.RockerR.RFB_T = [0.9950   -0.1950    -0.1520];

Rover.RockerR.CRJ_R = ...
    [1.0000         0         0
    0    0.0000   -1.0000
    0    1.0000    0.0000
    ];
Rover.RockerR.CRJ_T = [ -0.0000    0.1000   -0.0000];

Rover.BogieL.PSJ_R = ...
    [1.0000         0         0
         0    0.0000    1.0000
         0   -1.0000    0.0000];
Rover.BogieL.PSJ_T = [ 0 0 0];

Rover.BogieL.SLB_R =...
    [1.0000         0         0
         0    0.0000    1.0000
         0    1.0000    0.0000];
Rover.BogieL.SLB_T =[-0.4900    0.1100   -0.0950];

Rover.BogieL.SLM_R = ...
    [1.0000         0         0
         0    0.0000    1.0000
         0   -1.0000    0.0000];
Rover.BogieL.SLM_T = [0.5122    0.2901   -0.4162];

% MSR

Rover.BogieR.PSJ_R = ...
    [1.0000         0         0
         0    0.0000    1.0000
         0   -1.0000    0.0000];
Rover.BogieR.PSJ_T = [ 0 0 0];

Rover.BogieR.SRB_R =...
    [ 1.0000         0         0
         0   -1.0000         0
         0         0   -1.0000];

Rover.BogieR.SRB_T =[-0.4900    0.1100   0.0950];

Rover.BogieR.SRM_R = ...
    [1.0000         0         0
         0    0.0000    1.0000
         0   -1.0000    0.0000];
Rover.BogieR.SRM_T = [0.5122    0.2901   0.4162];

% SteeringBracket
Rover.SteerBracket.SRJ_R =...
    [0     0     1
     1     0     0
     0     1     0];
Rover.SteerBracket.SRJ_T = [0.3201   -0.0200   -0.0000];

Rover.SteerBracket.WRJ_R =...
    [1     0     0
     0     0     1
     0     -1     0];
Rover.SteerBracket.WRJ_T = [0.0000    0.0601    0.0000];

% Wheel
Rover.Wheel.WRJ_R =...
    [1     0     0
     0     0     1
     0     -1     0];
Rover.Wheel.WRJ_T = [0.0000   -0.0201    0.0000];

%
Rover.Chassis.Length = 2;
Rover.Chassis.Width = 1.761;
Rover.Wheel.Radius = 0.215; %m
Rover.Wheel.color_point_cloud = [0.07451 0.6235 1];
Rover.Wheel.opacity_point_cloud = 1;

Rover.Powertrain.Steer.Motor.max_torque   = 500;       % N*m
Rover.Powertrain.Steer.Motor.max_power    = 16000;     % W
Rover.Powertrain.Steer.Motor.tc_torque    = 2.0e-05;   % sec
Rover.Powertrain.Steer.Motor.efficiency   = 25/30*100; % percent
Rover.Powertrain.Steer.Motor.eff_meas_spd = 5000;      % rpm
Rover.Powertrain.Steer.Motor.eff_meas_trq = 300;       % N*m
Rover.Powertrain.Steer.Motor.damping      = 1.5e-2;      % (N*m/(rad/s))
Rover.Powertrain.Steer.Motor.gear_ratio   = 243;

Rover.Powertrain.Drive.Motor.max_torque   = 500;       % N*m
Rover.Powertrain.Drive.Motor.max_power    = 16000;     % W
Rover.Powertrain.Drive.Motor.tc_torque    = 2.0e-05;   % sec
Rover.Powertrain.Drive.Motor.efficiency   = 25/30*100; % percent
Rover.Powertrain.Drive.Motor.eff_meas_spd = 5000;      % rpm
Rover.Powertrain.Drive.Motor.eff_meas_trq = 300;       % N*m
Rover.Powertrain.Drive.Motor.damping      = 1.5e-2;      % (N*m/(rad/s))
Rover.Powertrain.Drive.Motor.gear_ratio   = 243;


%% Wheel Point Cloud
 temp_wpc = load('mars_rover_terrain_ptcloud_wheel.mat','wheel_point_cloud');
 Rover.Wheel.wheel_point_cloud = temp_wpc.wheel_point_cloud;
 clear temp_wpc

 Rover.Wheel.point_cloud_vis.rad = 0.5; % cm
 Rover.Wheel.point_cloud_vis.clr = [0.07451 0.6235 1];
 Rover.Wheel.point_cloud_vis.opc = 1;   % (0-1)

% Alternate color and size
% Rover.Wheel.point_cloud_vis.rad = 0.5*2.5; % cm
% Rover.Wheel.point_cloud_vis.clr = fliplr([0.07451 0.6235 1]);

% Code to plot point cloud
% wheel_point_cloud = mars_rover_terrain_ptcloud_wheel_create('rover_chassis_wheel_tread.stl');

%% PID Control Parameters for Wheel Speed Control and Steering Control
Control.Drive.Kp = 1e4;
Control.Drive.Ki = 50 ;
Control.Drive.Kd = 10;
Control.Drive.N  = 1000;
Control.Drive.FiltTargetw = 0.05; % Seconds
Control.Drive.FiltSensorw = 0.01; % Seconds
Control.Drive.TrqCmdLimitPos =  500; % N*m
Control.Drive.TrqCmdLimitNeg = -500; % N*m

Control.Drive.TargetSpeed = 0.3/10; % m/s
Control.Drive.TargetAccel = 0.5; % m/s^2
Control.Drive.StartTime = 1;     % roverStartTime



Control.Steer.Kp = 100;
Control.Steer.Ki = 1;
Control.Steer.Kd = 0.1;
Control.Steer.N  = 1000;
Control.Steer.FiltTargetq = 0.05; % Seconds
Control.Steer.FiltSensorq = 0.05; % Seconds

Control.Steer.TrqCmdLimitPos =  500; % N*m
Control.Steer.TrqCmdLimitNeg = -500; % N*m


%% Spatial Contact Force Block
Rover.Wheel_Surface.Contact.k = 1e6/5;
Rover.Wheel_Surface.Contact.d = 1e4;
Rover.Wheel_Surface.Contact.trans_depth = 0.3;
Rover.Wheel_Surface.Friction.mu_static = 0.8;
Rover.Wheel_Surface.Friction.mu_dynamic = 0.6;
Rover.Wheel_Surface.Friction.vel_crit = 1e-2;

%% Other Params
Rover.Steer.D = 10; % N*m/(deg/s)
Rover.Drive.D = 1;  % N*m/(deg/s)
% wheel_damping = 1;
