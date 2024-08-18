function mars_rover_terrain_plot2_arm_path(logsout)
%% Script to plot the end effector path

% Copyright 2021-2024 The MathWorks, Inc

% Reuse figure if it exists, else create new figure
if ~exist('h2_mars_rover_terrain', 'var') || ...
        ~isgraphics(h2_mars_rover_terrain, 'figure')
    h2_mars_rover_terrain = figure('Name', 'mars_rover_terrain');
end
figure(h2_mars_rover_terrain)
clf(h2_mars_rover_terrain)

temp_colororder = get(gca,'defaultAxesColorOrder');

RoverBus = logsout.get('RoverBus');
CtrlBus = logsout.get('CtrlBus');
simlog_sampleLoc = squeeze(CtrlBus.Values.Arm.Sample.Location.Data(1,:,end));

simlog_sampleLoc_Approach = [simlog_sampleLoc(1) simlog_sampleLoc(2) simlog_sampleLoc(3)+0.1];
eeConfig = evalin('base','eeConfig');

simlog_waypoints_arm = [...
    eeConfig.Targets{1,1:3};...
    eeConfig.Targets{2,1:3};...
    simlog_sampleLoc_Approach;...
    simlog_sampleLoc;...
    eeConfig.Targets{5,1:3};...
    eeConfig.Targets{6,1:3};
    eeConfig.Targets{7,1:3}];

simlog_EE_XYZ = RoverBus.Values.Arm.EExyz.Data;

plot3(simlog_EE_XYZ(:,1),simlog_EE_XYZ(:,2),simlog_EE_XYZ(:,3),'Color',temp_colororder(5,:),'LineWidth',1,'DisplayName','Trajectory')
hold on
plot3(simlog_waypoints_arm(:,1),simlog_waypoints_arm(:,2),simlog_waypoints_arm(:,3),'o','MarkerEdgeColor',temp_colororder(5,:),'MarkerFaceColor','k','LineWidth',1,'MarkerSize',4,'DisplayName','Waypoints')

plot3(simlog_waypoints_arm(1,1), simlog_waypoints_arm(1,2), simlog_waypoints_arm(1,3),'bd','LineWidth',2,'DisplayName','Home Position');
plot3(simlog_sampleLoc(1), simlog_sampleLoc(2), simlog_sampleLoc(3),'md','LineWidth',2,'DisplayName','Grab Sample');
plot3(simlog_waypoints_arm(6,1), simlog_waypoints_arm(6,2), simlog_waypoints_arm(6,3),'rd','LineWidth',2,'DisplayName','Store Sample');

title('End Effector Trajectory');

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
legend('Location','SouthEast');
hold off;
axis equal
grid on
box on

view(40,20)
