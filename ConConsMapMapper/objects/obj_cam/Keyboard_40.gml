if !(y + camera_speed <= room_height - 368) {
	while (y + sign(camera_speed) <= room_height - 368) {
		y += sign(camera_speed);
	}

}

else y += camera_speed;