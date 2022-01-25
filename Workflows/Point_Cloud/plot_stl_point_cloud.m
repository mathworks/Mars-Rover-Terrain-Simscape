function plot_stl_point_cloud(stlfilename,pointcloud,varargin)

% Copyright 2021-2022 The MathWorks, Inc

% Default mesh color
mesh_color = [0.6 0.6 0.6];

if (nargin==3)
    mesh_color = varargin{1};
end

% Figure name
figString = ['h1_' mfilename];
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


if(~strcmpi(stlfilename,'none'))
    f_ptCloud    = stlread(stlfilename);
    trimesh(f_ptCloud,'EdgeColor',mesh_color);
    hold on
end

plot3(pointcloud(:,1),pointcloud(:,2),pointcloud(:,3),'bo');%:,'MarkerFaceColor','r');
hold off

axis equal
ax = gca;              % Get the current axis
ax.Clipping = 'on';    
title(['Point Cloud for ' strrep(stlfilename,'_','\_')]);
box on
xlabel('x');ylabel('y');zlabel('z');
end