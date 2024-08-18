function mars_rover_terrain_plot5_armangles(logsout)
%% Script to plot the rover path

% Copyright 2021-2024 The MathWorks, Inc

% Figure name
figString = 'h5_mars_rover_terrain';
% Only create a figure if no figure exists
figExist = 0;
fig_hExist = evalin('base',['exist(''' figString ''')']);
if (fig_hExist)
    figExist = evalin('base',['ishandle(' figString ') && strcmp(get(' figString ', ''type''), ''figure'')']);
end
if ~figExist
    fig_h = figure('Name',figString);
    assignin('base',figString,fig_h);
else
    fig_h = evalin('base',figString);
end
figure(fig_h)
clf(fig_h)


temp_colororder = get(gca,'defaultAxesColorOrder');

RoverBus = logsout.get('RoverBus');
CtrlBus  = logsout.get('CtrlBus');

simlog_t  = RoverBus.Values.Arm.q.q1.Time;
simlog_q1 = RoverBus.Values.Arm.q.q1.Data;
simlog_q2 = RoverBus.Values.Arm.q.q2.Data;
simlog_q3 = RoverBus.Values.Arm.q.q3.Data;
simlog_q4 = RoverBus.Values.Arm.q.q4.Data;
simlog_q5 = RoverBus.Values.Arm.q.q5.Data;
simlog_q6 = RoverBus.Values.Arm.q.q6.Data;

simlog_t  = CtrlBus.Values.Arm.qCmd.q1.Time;
simlog_qCmd1 = CtrlBus.Values.Arm.qCmd.q1.Data;
simlog_qCmd2 = CtrlBus.Values.Arm.qCmd.q2.Data;
simlog_qCmd3 = CtrlBus.Values.Arm.qCmd.q3.Data;
simlog_qCmd4 = CtrlBus.Values.Arm.qCmd.q4.Data;
simlog_qCmd5 = CtrlBus.Values.Arm.qCmd.q5.Data;
simlog_qCmd6 = CtrlBus.Values.Arm.qCmd.q6.Data;



ah(1) = subplot(321);
plot(simlog_t, simlog_q1,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd1),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q1')
ylabel('rad')
grid on

ah(2) = subplot(322);
plot(simlog_t, simlog_q2,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd2),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q2')
ylabel('rad')
grid on

ah(3) = subplot(323);
plot(simlog_t, simlog_q3,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd3),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q3')
ylabel('rad')
grid on

ah(4) = subplot(324);
plot(simlog_t, simlog_q4,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd4),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q4')
ylabel('rad')
grid on

ah(5) = subplot(325);
plot(simlog_t, simlog_q5,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd5),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q4')
ylabel('rad')
xlabel('Time (s)')
grid on

ah(6) = subplot(326);
plot(simlog_t, simlog_q6,'DisplayName','Meas','LineWidth',1)
hold on
plot(simlog_t, squeeze(simlog_qCmd6),'--','DisplayName','Cmd','LineWidth',1)
hold off
title('q6')
ylabel('rad')
xlabel('Time (s)')
grid on

linkaxes(ah,'x')
