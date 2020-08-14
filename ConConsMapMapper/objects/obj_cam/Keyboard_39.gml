if !(x + camera_speed <= room_width - 368) {
	while (x + sign(camera_speed) <= room_width - 368) {
		x += sign(camera_speed);
	}

}

else x += camera_speed;