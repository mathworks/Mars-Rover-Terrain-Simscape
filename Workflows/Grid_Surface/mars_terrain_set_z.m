function mars_terrain_set_z(z_height_option)

% Copyright 2021-2024 The MathWorks, Inc

rover_path = evalin('base','rover_path');

switch (z_height_option)
    case 'uneven'
        evalin('base',['rover_path = ' rover_path.name ';'])
        evalin('base','mars_terrain_grid.z_heights = eval(''mars_terrain_grid.z_heights_data;'');')
        evalin('base','rover_path.z = interp2(mars_terrain_grid.xg,mars_terrain_grid.yg,mars_terrain_grid.z_heights'',rover_path.x,rover_path.y);');
        evalin('base','sample_position(3) = interp2(mars_terrain_grid.xg,mars_terrain_grid.yg,mars_terrain_grid.z_heights'',sample_position(1),sample_position(2));');
    case 'flat'
        %evalin('base',['rover_path = ' rover_path.name ';'])
        evalin('base','rover_path.z = rover_path.z*0;');
        evalin('base','rover_path.t0.pitch = 0;');
        evalin('base','rover_path.t0.roll  = 0;');
        evalin('base','rover_path.t0.pzOffset = 0.55;');
        evalin('base','mars_terrain_grid.z_heights = mars_terrain_grid.z_heights*0;')
        evalin('base','sample_position(3) = 0;');
end