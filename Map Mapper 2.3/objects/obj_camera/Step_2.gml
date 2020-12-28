#macro view view_camera[0]
camera_set_view_size(view,view_width,view_height);

camera_set_view_pos(view,obj_camera.x-view_width/2,obj_camera.y-view_width/2);