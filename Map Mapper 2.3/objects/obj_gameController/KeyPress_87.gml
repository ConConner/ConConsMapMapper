//var original_filename = get_open_filename("mage map file", "");
//var og_file = file_bin_open(original_filename, 0);

//var new_filename = get_save_filename("","");
//var new_file = file_bin_open(new_filename, 1);

//var og_size = file_bin_size(og_file);

//for (var i = 0; i < og_size; i++) {
	
//	//reading byte
//	file_bin_seek(og_file, i);
//	var read_byte = file_bin_read_byte(og_file);
	
//	//writing byte
//	file_bin_seek(new_file, i);
//	file_bin_write_byte(new_file, read_byte);
	
//}

//file_bin_close(og_file);
//file_bin_close(new_file);