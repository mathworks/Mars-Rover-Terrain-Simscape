function point_cloud = mars_rover_terrain_ptcloud_wheel_create(stlfilename,varargin)
%mars_rover_terrain_ptcloud_wheel_create Produce point cloud data from mars rover STL file.
%   point_cloud = mars_rover_terrain_ptcloud_wheel_create(stlfilename,<point_option>)  
%   This function returns x-y-z data extracted from STL geometry.
%   You can optionally specify:
%       Method for extracting points     point_option  (string)
%         'convex hull'  Uses convex hull to create rings at edges and near
%                        the center of the wheel. (default)
%         'bad radius'   Excludes points that are within a radius from the
%                        axis of symmetry. Radius value used is poor,
%                        resulting in an asymmetric point cloud
%                        (for demonstration only).
%         <all other>    Excludes points that are within a radius from the
%                        axis of symmetry. Radius value used is better,
%                        resulting in an symmetric point cloud
%
%  mars_rover_terrain_ptcloud_wheel_create('rover_chassis_wheel_tread.stl');

% Copyright 2021-2024 The MathWorks, Inc

point_option  = 'convex hull';  % Default option
pc_min_radius = 20.804;         % Good radius value

if(nargin==2)
    point_option = varargin{1};
end

if(strcmpi(point_option,'bad radius'))
    pc_min_radius = 20.5;       % Bad value, creates asymmetric point cloud
end

% Read in STL file
points = stlread(stlfilename);

% Extract unique points
all_pts = unique(points.Points,'Rows');
sorted_rows = sortrows(all_pts,2);

% Find points *near* middle
% Not exactly at middle, as STL file doesn't have points at middle
middle_rim_pts_1 = sorted_rows((sorted_rows(:,2)== median(sorted_rows(:,2))),:);

if (~strcmpi(point_option, 'convex hull'))
    % If not using convex hull

    % Find points along outer face of wheel
    outer_rim_pts = sorted_rows((sorted_rows(:,2)<= min(sorted_rows(:,2))+0.0001),:);

    % Only use points outside of a circle
    % This can cause problems if wheel is not round or not centered at 0
    r = [sqrt(outer_rim_pts(:,1).^2+ outer_rim_pts(:,3).^2)];
    outer_rim_pts = outer_rim_pts(r> pc_min_radius,:);

    % Find points along inner face of wheel
    inner_rim_pts = sorted_rows((sorted_rows(:,2)>= max(sorted_rows(:,2))-0.0001),:);

    % Only use points outside of a circle
    % This can cause problems if wheel is not round or not centered at 0
    r = [sqrt(inner_rim_pts(:,1).^2+ inner_rim_pts(:,3).^2)];
    inner_rim_pts = inner_rim_pts(r> pc_min_radius,:);

    % Assemble point cloud
    point_cloud = unique([outer_rim_pts ; middle_rim_pts_1; inner_rim_pts],'rows');

    % For debugging
    % disp(['Non Convex Hull -- Outer: ' num2str(size(outer_rim_pts,1)) ' Inner: ' num2str(size(inner_rim_pts,1))])
else

    % Get delaunay triangulation which can be edited
    points_dl = delaunayTriangulation(points.Points);

    % Find points to be eliminated (everything except outer edge)
    %exclude_outer_rim_inds= find(points_dl.Points(:,2)~=min(points_dl.Points(:,2)));
    exclude_outer_rim_inds= find(points_dl.Points(:,2)>=min(points_dl.Points(:,2))+0.001);

    % Create new delaunay triangulation
    outer_rim_tl  = points_dl;
    % Eliminate non-outer points
    outer_rim_tl.Points(exclude_outer_rim_inds,:) = [];

    % Create a 2D delaunay triangulation
    warning('off','MATLAB:triangulation:EmptyTri3DWarnId')
    outer_rim_2D_dl = delaunayTriangulation(outer_rim_tl.Points(:,1),outer_rim_tl.Points(:,3));
    warning('on','MATLAB:triangulation:EmptyTri3DWarnId')

    % Find indices of points on  convex hull
    pt_inds_cvh  = convexHull(outer_rim_2D_dl);

    % Use only those points in point cloud
    outer_rim_pts     = [outer_rim_2D_dl.Points(pt_inds_cvh,1) min(points_dl.Points(:,2))*ones(length(pt_inds_cvh),1) outer_rim_2D_dl.Points(pt_inds_cvh,2)];

    % Find points to be eliminated (everything except inner edge)
    exclude_inner_rim_inds= find(points_dl.Points(:,2)~=max(points_dl.Points(:,2)));

    % Create new delaunay triangulation
    inner_rim_tl  = points_dl;
    % Eliminate non-inner points
    inner_rim_tl.Points(exclude_inner_rim_inds,:) = [];

    % Create a 2D delaunay triangulation
    warning('off','MATLAB:triangulation:EmptyTri3DWarnId')
    inner_rim_2D_dl = delaunayTriangulation(inner_rim_tl.Points(:,1),inner_rim_tl.Points(:,3));
    warning('on','MATLAB:triangulation:EmptyTri3DWarnId')

    % Find indices of points on convex hull
    pt_inds_cvh  = convexHull(inner_rim_2D_dl);

    % Use only those points in point cloud
    inner_rim_pts     = [inner_rim_2D_dl.Points(pt_inds_cvh,1) max(points_dl.Points(:,2))*ones(length(pt_inds_cvh),1) inner_rim_2D_dl.Points(pt_inds_cvh,2)];

    % Assemble point cloud
    point_cloud = unique([outer_rim_pts ; middle_rim_pts_1; inner_rim_pts],'rows');

    % For debugging
    %disp(['Convex Hull -- Outer: ' num2str(size(outer_rim_pts,1)) ' Inner: ' num2str(size(inner_rim_pts,1))])
end

% Plot resulting point cloud with STL file mesh
plot_stl_point_cloud(stlfilename,point_cloud);
