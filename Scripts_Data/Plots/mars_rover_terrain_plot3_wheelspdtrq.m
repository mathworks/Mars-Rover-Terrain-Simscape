%% Script to plot the rover path

% Copyright 2021-2024 The MathWorks, Inc

% Check for simulation results
if ~exist('logsout_mars_rover_terrain', 'var')
    error('logsout_mars_rover_terrain data not available.')
end

% Reuse figure if it exists, else create new figure
if ~exist('h3_mars_rover_terrain', 'var') || ...
        ~isgraphics(h3_mars_rover_terrain, 'figure')
    h3_mars_rover_terrain = figure('Name', 'mars_rover_terrain');
end
figure(h3_mars_rover_terrain)
clf(h3_mars_rover_terrain)

temp_colororder = get(gca,'defaultAxesColorOrder');

RoverBus = logsout_mars_rover_terrain.get('RoverBus');
simlog_t   = RoverBus.Values.Chassis.Wheels.Drive.w.L1.Time;
simlog_wL1 = RoverBus.Values.Chassis.Wheels.Drive.w.L1.Data;
simlog_wL2 = RoverBus.Values.Chassis.Wheels.Drive.w.L2.Data;
simlog_wL3 = RoverBus.Values.Chassis.Wheels.Drive.w.L3.Data;
simlog_wR1 = RoverBus.Values.Chassis.Wheels.Drive.w.R1.Data;
simlog_wR2 = RoverBus.Values.Chassis.Wheels.Drive.w.R2.Data;
simlog_wR3 = RoverBus.Values.Chassis.Wheels.Drive.w.R3.Data;
simlog_trqL1 = RoverBus.Values.Chassis.Wheels.Drive.trq.L1.Data;
simlog_trqL2 = RoverBus.Values.Chassis.Wheels.Drive.trq.L2.Data;
simlog_trqL3 = RoverBus.Values.Chassis.Wheels.Drive.trq.L3.Data;
simlog_trqR1 = RoverBus.Values.Chassis.Wheels.Drive.trq.R1.Data;
simlog_trqR2 = RoverBus.Values.Chassis.Wheels.Drive.trq.R2.Data;
simlog_trqR3 = RoverBus.Values.Chassis.Wheels.Drive.trq.R3.Data;


ah(1) = subplot(211);
plot(simlog_t, simlog_wL1,'DisplayName','L1','LineWidth',1)
hold on
plot(simlog_t, simlog_wL2,'DisplayName','L2','LineWidth',1)
plot(simlog_t, simlog_wL3,'DisplayName','L3','LineWidth',1)
plot(simlog_t, simlog_wR1,'DisplayName','R1','LineWidth',1)
plot(simlog_t, simlog_wR2,'DisplayName','R2','LineWidth',1)
plot(simlog_t, simlog_wR3,'DisplayName','R3','LineWidth',1)
hold off;
title('Wheel Speeds');
legend('Location','Best');
%xlabel('Time (s)');
ylabel('Speed (rad/s)');
grid on

ah(2) = subplot(212);

plot(simlog_t, simlog_trqL1,'DisplayName','L1','LineWidth',1)
hold on
plot(simlog_t, simlog_trqL2,'DisplayName','L2','LineWidth',1)
plot(simlog_t, simlog_trqL3,'DisplayName','L3','LineWidth',1)
plot(simlog_t, simlog_trqR1,'DisplayName','R1','LineWidth',1)
plot(simlog_t, simlog_trqR2,'DisplayName','R2','LineWidth',1)
plot(simlog_t, simlog_trqR3,'DisplayName','R3','LineWidth',1)
hold off;
title('Wheel Torque');
legend('Location','Best');
xlabel('Time (s)');
ylabel('Torque (N*m)');
grid on

linkaxes(ah,'x')
