zoom = -10

camera = camera_create();

var vm = matrix_build_lookat(x,y,zoom,x,y,0,0,1,0);
var pm = matrix_build_projection_ortho(800,800,1,10000);

camera_set_view_mat(camera,vm);
camera_set_proj_mat(camera,pm);

view_camera[0] = camera;

xto = x;
yto = y;
camera_speed = 6;