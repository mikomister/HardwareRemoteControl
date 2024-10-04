module _create_round_corner(length, radius, fn) {
	difference() {
		cube([ radius * 2, radius * 2, length + 0.02 ]);
		cylinder(h = length + 0.02, r1 = radius, r2 = radius, $fn = fn);
	}
}

module roundcorner(cube_size, corner_strings_array, radius = 2, fn = 16) {
	xsize = cube_size[0];
	ysize = cube_size[1];
	zsize = cube_size[2];
	
	for (i = [0:len(corner_strings_array) - 1])
	{
		corner_string = str(corner_strings_array[i]);
		if (corner_string == "t1" || corner_string == "u1") {
			translate([xsize + 0.01, radius, zsize - radius]) rotate([90, 0, 270]) _create_round_corner(xsize, radius, fn);
		} else if (corner_string == "t2" || corner_string == "u2") {
			translate([xsize - radius, ysize + 0.01, zsize - radius]) rotate([90, 0, 0]) _create_round_corner(ysize, radius, fn);
		} else if (corner_string == "t3" || corner_string == "u3") {
			translate([-0.01, ysize - radius, zsize - radius]) rotate([90, 0, 90]) _create_round_corner(xsize, radius, fn);
		} else if (corner_string == "t4" || corner_string == "u4") {
			translate([radius, -0.01, zsize - radius]) rotate([90, 0, 180]) _create_round_corner(ysize, radius, fn);
		} else if (corner_string == "b1" || corner_string == "d1") {
			translate([-0.01, radius, radius]) rotate([270, 0, 270]) _create_round_corner(xsize, radius, fn);
		} else if (corner_string == "b2" || corner_string == "d2") {
			translate([xsize - radius, ysize + 0.01, radius]) rotate([0, 90, 270]) _create_round_corner(ysize, radius, fn);
		} else if (corner_string == "b4" || corner_string == "d4") {
			translate([radius, ysize + 0.01, radius]) rotate([270, 0, 180]) _create_round_corner(ysize, radius, fn);
		} else if (corner_string == "b3" || corner_string == "d3") {
			translate([-0.01, ysize - radius, radius]) rotate([0, 90, 0]) _create_round_corner(xsize, radius, fn);
		} else if (corner_string == "1") {
			translate([radius, radius, -0.01]) rotate([0, 0, 180]) _create_round_corner(zsize, radius, fn);
		} else if (corner_string == "2") {
			translate([xsize - radius, radius, -0.01]) rotate([0, 0, 270]) _create_round_corner(zsize, radius, fn);
		} else if (corner_string == "3") {
			translate([xsize - radius, ysize-radius, -0.01]) rotate([0, 0, 0]) _create_round_corner(zsize, radius, fn);
		} else if (corner_string == "4") {
			translate([radius, ysize-radius, -0.01]) rotate([0, 0, 90]) _create_round_corner(zsize, radius, fn);
		}
	}
}

module cuberounded(cube_size, corner_strings_array, radius = 2, fn = 16, fastpreview = false) {
	difference() {
		cube(cube_size);
		if (!fastpreview) {
			roundcorner(cube_size, corner_strings_array, radius, fn);
		}
	}
}