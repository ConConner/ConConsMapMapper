if (xx != global.xx || yy != global.yy || !obj_gameController.mLeft) instance_destroy();

if (image_index >= 30) {
	obj_gameController.did_hold = true;
	instance_destroy();
}