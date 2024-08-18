%% Extracting Point Cloud from STL Geometry: Wheel
% 
% This example shows MATLAB commands to obtain coordinates for the point
% cloud that is used to detect collision between the wheels and the ground
% terrain. The STL file for the wheel tread is read into MATLAB, and then a
% few commands are used to extract just the points that are useful for the
% contact and friction force calculation.
%
% The code used in the example is <matlab:edit('mars_rover_terrain_ptcloud_wheel_create.m') mars_rover_terrain_ptcloud_wheel_create.m>. 
% 
% Return to main example <matlab:web('mars_rover_terrain.html');
% mars_rover_terrain>
%
% Copyright 2021-2024 The MathWorks, Inc


%% Read in the STL file, plot mesh
%
% The <matlab:doc('stlread') stlread> and <matlab:doc('trimesh') trimesh> commands are very useful for working with STL
% files.

wheel_stl_points = stlread('rover_chassis_wheel_tread.stl');
trimesh(wheel_stl_points,'EdgeColor',[0.6 0.6 0.6])
axis equal
box on
title('STL Mesh')


%% Filter Points Based on Location
%
% As the data is all in x-y-z coordinates, we could look for points on the
% edge of the wheel on the tips of the fins.  With STL files, you sometimes
% need to eliminate duplicate points using the MATLAB command
% <matlab:doc('unique') unique>.  The code below finds points on the wheel 
% edge that are outside a specified radius.

wheel_stl_points_unique = unique(wheel_stl_points.Points,'Rows');

point_radius = sqrt(wheel_stl_points_unique(:,1).^2 + wheel_stl_points_unique(:,3).^2);

edge_points = wheel_stl_points_unique(...
    intersect(find(point_radius>=20.804),find(wheel_stl_points_unique(:,2)<-0.049)),:);

figure(1)
trimesh(wheel_stl_points,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_points(:,1),edge_points(:,2),edge_points(:,3),'bo')
axis equal
box on
hold off
title('Points for Inner Edge')

%% Filter Points Based on Location: Caution
%
% Filtering by location can be challenging if the point cloud is not
% aligned with or centered about a certain axis or plane.  This can be seen
% on the wheel if we change the threshold radius for including points.

edge_points = wheel_stl_points_unique(...
    intersect(find(point_radius>=20.5),find(wheel_stl_points_unique(:,2)<-0.049)),:);

figure(2)
trimesh(wheel_stl_points,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(edge_points(:,1),edge_points(:,2),edge_points(:,3),'bo')
axis equal
box on
hold off
title('Points for Inner Edge: Asymmetric Result')
view(0,12)

%% Filter Points Using Convex Hull
%
% Another method which is useful is extracting the points that form a
% convex hull. This is the smallest set of points that completely contains
% the shape, which for our wheel is useful. The resulting set would work
% for modeling contact between the wheel and the ground, but has many more
% points than we need for relatively smooth terrain.  
%
% Obtaining this set of points uses <matlab:doc('delaunayTriangulation')
% delaunayTriangulation> and <matlab:doc('convexHull') convexHull>.

wheel_stl_points_tri = delaunayTriangulation(wheel_stl_points_unique);
cvh_inds  = convexHull(wheel_stl_points_tri);

figure(3)
trimesh(wheel_stl_points,'EdgeColor',[0.6 0.6 0.6])
hold on
plot3(wheel_stl_points_tri.Points(cvh_inds,1),...
    wheel_stl_points_tri.Points(cvh_inds,2),...
    wheel_stl_points_tri.Points(cvh_inds,3),'b.')
axis equal
box on
hold off
title('Points Using Convex Hull')
view(0,12)

%% Reduced Set of Points using Convex Hull and Location-Based Filtering
%
% Combining these two techniques we can obtain a set of points that is
% sufficient to accurately model contact and permits efficient simulation.
% The code used to extract the point is
% <matlab:edit('mars_rover_terrain_ptcloud_wheel_create')
% mars_rover_terrain_ptcloud_wheel_create.m>

mars_rover_terrain_ptcloud_wheel_create('rover_chassis_wheel_tread.stl');

%% Use Point Cloud Data in Simscape Model
%
% The point cloud data (x-y-z data) can be used to define a point cloud
% for use with contact modeling.  In the rover model, this data
% is entered into the Point Cloud block.

load_system('mars_rover_terrain');
open_system('mars_rover_terrain/Rover/Chassis/Roll and Steer/Drive/Wheel L1','force')

%%
bdclose('mars_rover_terrain')
close all
