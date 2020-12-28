if (image_alpha > 0.25 && a_switch == 0) image_alpha -=0.02;
if (image_alpha <= 0.25) a_switch = 1;
if (image_alpha < 0.9 && a_switch == 1) image_alpha +=0.02;
if (image_alpha >= 0.9) a_switch = 0;

x += (global.xx * 32 - x)/1.5
y += (global.yy * 32 - y)/1.5

if (!obj_gameController.canBuild) image_alpha = 0;
