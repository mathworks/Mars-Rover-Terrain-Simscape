%% Script to plot the rover path

% Copyright 2021-2024 The MathWorks, Inc

% Check for simulation results
if ~exist('logsout_mars_rover_terrain', 'var')
    error('logsout_mars_rover_terrain data not available.')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_mars_rover_terrain', 'var') || ...
        ~isgraphics(h1_mars_rover_terrain, 'figure')
    h1_mars_rover_terrain = figure('Name', 'mars_rover_terrain');
end
figure(h1_mars_rover_terrain)
clf(h1_mars_rover_terrain)

temp_colororder = get(gca,'defaultAxesColorOrder');

RoverBus = logsout_mars_rover_terrain.get('RoverBus');
rov_px = RoverBus.Values.Body.xyz.Data(:,1);
rov_py = RoverBus.Values.Body.xyz.Data(:,2);

refPathx_vec = linspace(min(rover_path.x),max(rover_path.x),length(rov_px));

plot(rover_path.x, rover_path.y,'b--o','LineWidth',1,'DisplayName','Waypoints')
hold on
plot(rov_px,rov_py,'Color',temp_colororder(3,:),'LineWidth',2,'DisplayName','Path');
plot(sample_position(1),sample_position(2),'rx','MarkerSize',12,'DisplayName','Sample')
hold off;
title('Rover Path Comparison in XY plane');
legend('Location','Best');
xlabel('X (m)');
ylabel('Y (m)');

grid on
axis equal
