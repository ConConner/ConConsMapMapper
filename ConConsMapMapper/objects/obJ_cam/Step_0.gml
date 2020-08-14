cX = camera_get_view_x(camera);
cY = camera_get_view_y(camera);

camMouseX = mouse_x - cX;
camMouseY = mouse_y - cY;

//if (camMouseX >= 0 && camMouseX <=20) x -= camera_speed;
//if (camMouseX >= 780 && camMouseX <=800) x += camera_speed;


var vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0);
camera_set_view_mat(camera,vm);