if !(x - camera_speed >= 368) {
	while (x - sign(camera_speed) >= 368) {
		x -= sign(camera_speed);
	}

}

else x -= camera_speed;