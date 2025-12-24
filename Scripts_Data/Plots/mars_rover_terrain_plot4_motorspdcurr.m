%% Script to plot the rover path

% Copyright 2021-2025 The MathWorks, Inc

% Check for simulation results
if ~exist('logsout_mars_rover_terrain', 'var')
    error('logsout_mars_rover_terrain data not available.')
end

% Reuse figure if it exists, else create new figure
if ~exist('h4_mars_rover_terrain', 'var') || ...
        ~isgraphics(h4_mars_rover_terrain, 'figure')
    h4_mars_rover_terrain = figure('Name', 'mars_rover_terrain');
end
figure(h4_mars_rover_terrain)
clf(h4_mars_rover_terrain)

temp_colororder = get(gca,'defaultAxesColorOrder');

RoverBus = logsout_mars_rover_terrain.get('RoverBus');
simlog_t   = RoverBus.Values.Chassis.Powertrain.Drive.w.L1.Time;
simlog_wL1 = RoverBus.Values.Chassis.Powertrain.Drive.w.L1.Data;
simlog_wL2 = RoverBus.Values.Chassis.Powertrain.Drive.w.L2.Data;
simlog_wL3 = RoverBus.Values.Chassis.Powertrain.Drive.w.L3.Data;
simlog_wR1 = RoverBus.Values.Chassis.Powertrain.Drive.w.R1.Data;
simlog_wR2 = RoverBus.Values.Chassis.Powertrain.Drive.w.R2.Data;
simlog_wR3 = RoverBus.Values.Chassis.Powertrain.Drive.w.R3.Data;
simlog_wLS1 = RoverBus.Values.Chassis.Powertrain.Steer.w.L1.Data;
simlog_wLS3 = RoverBus.Values.Chassis.Powertrain.Steer.w.L3.Data;
simlog_wRS1 = RoverBus.Values.Chassis.Powertrain.Steer.w.R1.Data;
simlog_wRS3 = RoverBus.Values.Chassis.Powertrain.Steer.w.R3.Data;

CtrlBus = logsout_mars_rover_terrain.get('CtrlBus');
simlog_trqL1 = CtrlBus.Values.Chassis.Drive.trq.L1.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqL2 = CtrlBus.Values.Chassis.Drive.trq.L2.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqL3 = CtrlBus.Values.Chassis.Drive.trq.L3.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqR1 = CtrlBus.Values.Chassis.Drive.trq.R1.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqR2 = CtrlBus.Values.Chassis.Drive.trq.R2.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqR3 = CtrlBus.Values.Chassis.Drive.trq.R3.Data/Rover.Powertrain.Drive.Motor.gear_ratio;
simlog_trqLS1 = CtrlBus.Values.Chassis.Steer.trq.L1.Data/Rover.Powertrain.Steer.Motor.gear_ratio;
simlog_trqLS3 = CtrlBus.Values.Chassis.Steer.trq.L3.Data/Rover.Powertrain.Steer.Motor.gear_ratio;
simlog_trqRS1 = CtrlBus.Values.Chassis.Steer.trq.R1.Data/Rover.Powertrain.Steer.Motor.gear_ratio;
simlog_trqRS3 = CtrlBus.Values.Chassis.Steer.trq.R3.Data/Rover.Powertrain.Steer.Motor.gear_ratio;


if(isfield(RoverBus.Values.Chassis.Powertrain.Drive,'i'))
    simlog_iL1 = RoverBus.Values.Chassis.Powertrain.Drive.i.L1.Data;
    simlog_iL2 = RoverBus.Values.Chassis.Powertrain.Drive.i.L2.Data;
    simlog_iL3 = RoverBus.Values.Chassis.Powertrain.Drive.i.L3.Data;
    simlog_iR1 = RoverBus.Values.Chassis.Powertrain.Drive.i.R1.Data;
    simlog_iR2 = RoverBus.Values.Chassis.Powertrain.Drive.i.R2.Data;
    simlog_iR3 = RoverBus.Values.Chassis.Powertrain.Drive.i.R3.Data;
    titlestr = 'Motor Current';
    ylabelstr = 'Current (A)';
else
    simlog_iL1 = RoverBus.Values.Chassis.Powertrain.Drive.trq.L1.Data;
    simlog_iL2 = RoverBus.Values.Chassis.Powertrain.Drive.trq.L2.Data;
    simlog_iL3 = RoverBus.Values.Chassis.Powertrain.Drive.trq.L3.Data;
    simlog_iR1 = RoverBus.Values.Chassis.Powertrain.Drive.trq.R1.Data;
    simlog_iR2 = RoverBus.Values.Chassis.Powertrain.Drive.trq.R2.Data;
    simlog_iR3 = RoverBus.Values.Chassis.Powertrain.Drive.trq.R3.Data;
    titlestr = 'Motor Torque';
    ylabelstr = 'Torque (N*m)';
end

ah(1) = subplot(211);
plot(simlog_t, simlog_wL1*30/pi,'DisplayName','L1','LineWidth',1)
hold on
plot(simlog_t, simlog_wL2*30/pi,'DisplayName','L2','LineWidth',1)
plot(simlog_t, simlog_wL3*30/pi,'DisplayName','L3','LineWidth',1)
plot(simlog_t, simlog_wR1*30/pi,'DisplayName','R1','LineWidth',1)
plot(simlog_t, simlog_wR2*30/pi,'DisplayName','R2','LineWidth',1)
plot(simlog_t, simlog_wR3*30/pi,'DisplayName','R3','LineWidth',1)
hold off;
title('Motor Speed');
legend('Location','Best');
xlabel('Time (s)');
ylabel('Speed (rpm)');
grid on

ah(2) = subplot(212);
plot(simlog_t, simlog_iL1,'DisplayName','L1','LineWidth',1)
hold on
plot(simlog_t, simlog_iL2,'DisplayName','L2','LineWidth',1)
plot(simlog_t, simlog_iL3,'DisplayName','L3','LineWidth',1)
plot(simlog_t, simlog_iR1,'DisplayName','R1','LineWidth',1)
plot(simlog_t, simlog_iR2,'DisplayName','R2','LineWidth',1)
plot(simlog_t, simlog_iR3,'DisplayName','R3','LineWidth',1)
hold off;
title(titlestr);
legend('Location','Best');
xlabel('Time (s)');
ylabel(titlestr);

grid on

linkaxes(ah,'x');

% Reuse figure if it exists, else create new figure
if ~exist('h4a_mars_rover_terrain', 'var') || ...
        ~isgraphics(h4a_mars_rover_terrain, 'figure')
    h4a_mars_rover_terrain = figure('Name', 'mars_rover_terrain');
end
figure(h4a_mars_rover_terrain)
clf(h4a_mars_rover_terrain)

simlog_drive_pwr = ...
    simlog_wL1.*simlog_trqL1 + ...
    simlog_wL2.*simlog_trqL2 + ...
    simlog_wL3.*simlog_trqL3 + ...
    simlog_wR1.*simlog_trqR1 + ...
    simlog_wR2.*simlog_trqR2 + ...
    simlog_wR3.*simlog_trqR3 + ...
    simlog_wLS1.*simlog_trqLS1 + ...
    simlog_wLS3.*simlog_trqLS3 + ...
    simlog_wRS1.*simlog_trqRS1 + ...
    simlog_wRS3.*simlog_trqRS3;

plot(simlog_t,simlog_drive_pwr)

title('Power Consumption, Drive and Steer Motors')
ylabel('Power (W)')
xlabel('Time (s)')
grid on