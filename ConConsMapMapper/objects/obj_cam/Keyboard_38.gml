if !(y - camera_speed >= 368) {
	while (y - sign(camera_speed) >= 368) {
		y -= sign(camera_speed);
	}

}

else y -= camera_speed;