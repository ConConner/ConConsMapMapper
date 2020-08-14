kLeft = keyboard_check(vk_left);
kRight= keyboard_check(vk_right);
kUp= keyboard_check(vk_up);
kDown= keyboard_check(vk_down);


if (kLeft) x-=camera_speed;
if (kRight) x+=camera_speed;
if (kUp) y-=camera_speed;
if (kDown) y+=camera_speed;

var vm = matrix_build_lookat(x,y,-10,x,y,0,0,1,0);
camera_set_view_mat(camera,vm);
