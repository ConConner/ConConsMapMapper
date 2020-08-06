x = global.cX*32
y = global.cY*32

if (image_alpha > 0.25 && a_switch == 0) image_alpha -=0.02;
if (image_alpha <= 0.25) a_switch = 1;
if (image_alpha < 0.9 && a_switch == 1) image_alpha +=0.02;
if (image_alpha >= 0.9) a_switch = 0;

