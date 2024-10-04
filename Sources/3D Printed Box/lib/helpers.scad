module up(value = 0) {
	translate([0, 0, value]) children();
}

module down(value = 0) {
	translate([0, 0, -value]) children();
}

module left(value = 0) {
	translate([-value, 0, 0]) children();
}

module right(value = 0) {
	translate([value, 0, 0]) children();
}

module left(value = 0) {
	translate([-value, 0, 0]) children();
}

module closer(value = 0) {
	translate([0, -value, 0]) children();
}

module in(value = 0) {
	translate([0, -value, 0]) children();
}

module further(value = 0) {
	translate([0, value, 0]) children();
}

module out(value = 0) {
	translate([0, value, 0]) children();
}

module xy(x = 0, y = 0) {
	translate([x, y, 0]) children();
}

function isSet(array, index) = len(array) > index && array[index];

function getFanBoltDiameter() = 4.4;
function getFanBoltLength() = 10.5;

module fanBolt(inverted = false) {
	boltLength = getFanBoltLength();
	boltDiameter = getFanBoltDiameter();
	boltCapDiameter = 6.4;
	boltCapLength = 0.7;
	boltCapToBoltLength = 0.8;
	over = 0.01;
	fn = $preview ? 16 : 128;
	
	rotate([inverted ? 180 : 0, 0, 0]) {
		cylinder(h = boltCapLength, d = boltCapDiameter, $fn = fn);
		up(boltCapLength - over) cylinder(h = boltCapToBoltLength, d1 = boltCapDiameter, d2 = boltDiameter, $fn = fn);
		up(boltCapLength + boltCapToBoltLength - over * 2) cylinder(h = boltLength - boltCapToBoltLength - boltCapLength, d = boltDiameter, $fn = fn);
	}
}

/*
function moduleBoxOuterSize(insize, wallsThick = 3, topThick = 5, bottomThick = 8, columnsSize = 10, columnsOnSize = 0, stiffeningRibs = [], stiffeningRibsHeight = 5, stiffeningRibsThick = 3) = [ insize[0] + wallsThick * 2 + (insize[0] < insize[1] && columnsOnSize == 0 ? columnsSize * 2 : 0) + (columnsOnSize == 1 ? columnsSize * 2 : 0), insize[1] + wallsThick * 2 + (insize[1] < insize[0] && columnsOnSize == 0 ? columnsSize * 2 : 0) + (columnsOnSize == 2 ? columnsSize * 2 : 0), insize[2] + topThick + bottomThick ];
*/

function moduleBoxOuterSize(insize, wallsThick = 3, topThick = 3, bottomThick = 3, columnsSize = 10) = [ insize[0] + wallsThick * 2 + columnsSize * 2, insize[1] + wallsThick * 2 + columnsSize * 2, insize[2] + topThick + bottomThick ];

module moduleBoxInto(insize, wallsThick = 3, bottomThick = 3, columnsSize = 10) {
	//outsizes = moduleBoxOuterSize(insize, wallsThick, topThick, bottomThick, columnsSize);
	translate([wallsThick + columnsSize, wallsThick + columnsSize, bottomThick]) children();
}

//stiffeningRibs / previewParts order 0 - bottom, 1 - top, 2 - front/back, 3 - left/right
module moduleBox(insize, wallsThick = 3, topThick = 5, bottomThick = 8, columnsSize = 10, sideBolts = true, stiffeningRibs = [1,1,1,1], stiffeningRibsThick = 3, previewParts = [1,1,1,1]) {
	over = 0.01;
	precisionSR = 1;
	outsizes = moduleBoxOuterSize(insize, wallsThick, topThick, bottomThick, columnsSize);
	outerWidth = outsizes[0];
	outerHeight = outsizes[2];
	outerDepth = outsizes[1];
	boltsOffset = getFanBoltLength() + 2;
	
	difference() {
		union() {
			//bottom
			if (!$preview || len(previewParts) > 0 && previewParts[0]) union() {
				down(over)
				hull() {
					cube([outerWidth, outerDepth, 0.001]);
					up(bottomThick) xy(wallsThick, wallsThick) cube([outerWidth - wallsThick * 2, outerDepth - wallsThick * 2, 0.001]);
				}
				if (isSet(stiffeningRibs, 0)) {
					color([0.5, 0.5, 0.5]) up(bottomThick - over) {
						for (i = [0, 1]) {
							xy(wallsThick + columnsSize + precisionSR, wallsThick + precisionSR) 
								out(i * (outerDepth - wallsThick * 2 - stiffeningRibsThick - precisionSR * 2))
									cube([outerWidth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize - over]);
						}
						right(outerWidth) rotate([0, 0, 90])
						for (i = [0, 1]) {
							xy(wallsThick + columnsSize + precisionSR, wallsThick + precisionSR) 
								out(i * (outerWidth - wallsThick * 2 - stiffeningRibsThick - precisionSR * 2))
									cube([outerDepth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize - over]);
						}
					}
				}
			}
			
			//top
			if (!$preview || len(previewParts) > 1 && previewParts[1]) union() {
				up(outerHeight) up(over)
				hull() {
					cube([outerWidth, outerDepth, 0.001]);
					down(topThick) xy(wallsThick, wallsThick) cube([outerWidth- wallsThick * 2, outerDepth - wallsThick * 2, 0.001]);
				}
				if (isSet(stiffeningRibs, 1)) {
					color([0.5, 0.5, 0.5]) up(outerHeight - topThick - columnsSize + over) {
						for (i = [0, 1]) {
							xy(wallsThick + columnsSize + precisionSR, wallsThick + precisionSR) 
								out(i * (outerDepth - wallsThick * 2 - stiffeningRibsThick - precisionSR * 2))
									cube([outerWidth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize]);
						}
						right(outerWidth) rotate([0, 0, 90])
						for (i = [0, 1]) {
							xy(wallsThick + columnsSize + precisionSR, wallsThick + precisionSR) 
								out(i * (outerWidth - wallsThick * 2 - stiffeningRibsThick - precisionSR * 2))
									cube([outerDepth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize]);
						}
					}
				}
			}
			
			//front & back
			if (!$preview || len(previewParts) > 2 && previewParts[2]) {
				for (i = [0, 1]) {
					in((i == 0 ? over : - over)) right(outerWidth * i) out(outerDepth * i) rotate([0, 0, 180 * i]) union() {
						hull() {
							cube([outerWidth, 0.001, outerHeight]);
							up(bottomThick) xy(wallsThick, wallsThick) cube([outerWidth - wallsThick * 2, 0.001, outerHeight - bottomThick - topThick]);
						}
						if (sideBolts) {
							for (j = [0, 1]) {
								right(j * (outerWidth - columnsSize - wallsThick * 2)) up(bottomThick) xy(wallsThick, wallsThick) cube([columnsSize, columnsSize, outerHeight - bottomThick - topThick]);
							}
						}
						
						if (isSet(stiffeningRibs, 2)) {
							color([0.5, 0.5, 0.5]) up(outerHeight) rotate([-90, 0, 0])
							up(wallsThick - over) {
								for (i = [0, 1]) {
									xy(wallsThick + columnsSize + precisionSR, wallsThick + columnsSize + precisionSR ) 
										out(i * (outerHeight - topThick - bottomThick - stiffeningRibsThick - precisionSR * 2 - columnsSize * 2))
											cube([outerWidth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize]);
								}
							}
						}
					}
				}
			}
			
			//left && right
			if (!$preview || len(previewParts) > 3 && previewParts[3]) {
				right(outerWidth) rotate([0, 0, 90])
				for (i = [0, 1]) {
					in((i == 0 ? over : - over)) right(outerDepth * i) out(outerWidth * i) rotate([0, 0, 180 * i]) union() {
						hull() {
							cube([outerDepth, 0.001, outerHeight]);
							up(bottomThick) xy(wallsThick, wallsThick) cube([outerDepth - wallsThick * 2, 0.001, outerHeight - bottomThick - topThick]);
						}
						if (!sideBolts) {
							for (j = [0, 1]) {
								right(j * (outerDepth - columnsSize - wallsThick * 2)) up(bottomThick) xy(wallsThick, wallsThick) cube([columnsSize, columnsSize, outerHeight - bottomThick - topThick]);
							}
						}
						
						if (isSet(stiffeningRibs, 2)) {
							color([0.5, 0.5, 0.5]) up(outerHeight) rotate([-90, 0, 0])
							up(wallsThick - over) {
								for (i = [0, 1]) {
									xy(wallsThick + columnsSize + precisionSR, wallsThick + columnsSize + precisionSR) 
										out(i * (outerHeight - topThick - bottomThick - stiffeningRibsThick - precisionSR * 2 - columnsSize * 2))
											cube([outerDepth - wallsThick * 2 - columnsSize * 2 - precisionSR * 2, stiffeningRibsThick, columnsSize]);
								}
							}
						}
					}
				}
			}
		}
		xy(outerWidth / 2, outerDepth / 2) 
			for (s = [0, 1])
				down(over * 2)
				for (i = [-1, 1])
					for (j = [-1, 1])
						right((outerWidth / 2 - wallsThick - columnsSize / 2) * j)
							out((outerDepth / 2 - wallsThick - columnsSize / 2) * i)
								up((outerHeight + over * 4) * s)
									fanBolt(s);
		if (sideBolts) {
			right(outerWidth) rotate([0, 0, 90])
			for (i = [0, 1])
				in((i == 0 ? over : - over)) right(outerDepth * i) out(outerWidth * i) rotate([0, 0, 180 * i]) 
					right(outerDepth / 2) up(outerHeight / 2)
						for (i = [-1, 1])
							for (j = [-1, 1])
								up((outerHeight / 2 - wallsThick - boltsOffset) * j)
									right((outerDepth / 2 - wallsThick - columnsSize / 2) * i) in(over)
										rotate([-90, 0, 0]) fanBolt();
		} else {
			for (i = [0, 1])
				in((i == 0 ? over : - over)) right(outerWidth * i) out(outerDepth * i) rotate([0, 0, 180 * i])
					right(outerWidth / 2) up(outerHeight / 2)
						for (i = [-1, 1])
							for (j = [-1, 1])
								up((outerHeight / 2 - wallsThick - boltsOffset) * j)
									right((outerWidth / 2 - wallsThick - columnsSize / 2) * i) in(over)
										rotate([-90, 0, 0]) fanBolt();
		}
	}
}





module _pyramid(size, thick, outer = true) {

translate([0, 0, (outer ? 0 : thick)]) mirror([0, 0, (outer ? 0 : 1)])
polyhedron(
  points=[
			[size,size,thick], [size, 0, thick], [0,0, thick], [0,size, thick], //0-3
           [size / 2, size / 2,size / 2 + thick], // 4
		   
			[size,size,0], [size, 0,0], [0,0,0], [0,size,0], //5-8
			[size / 2, size / 2,size / 2 ], // 9
			
			[size - thick,size - thick,0], [size - thick, thick,0], [thick,thick,0], [thick,size - thick,0],  // 10-13
			
			[size - thick,size - thick,thick], [size - thick, thick,thick], [thick,thick,thick], [thick,size - thick,thick], //14-17
		 ],                                 
  faces=[ 
			[0,1,4], [1,2,4], [2,3,4], [3,0,4],
			[0, 5, 1], [1, 5, 6], [1, 7, 2], [1, 7, 6], [2, 8, 3], [2, 8, 7], [3, 5, 0], [3, 5, 8],
			[5, 10, 11], [5, 6, 11], [6, 11, 12], [6, 7, 12], [7, 12, 13], [7, 8, 13], [8, 13, 10], [8, 5, 10],
			
			[10, 14, 11], [11, 14, 15], [11, 15, 12], [12, 15, 16], [12, 16, 13], [13, 16, 17], [13, 17, 10], [10, 17, 14], 
			
			[14, 15, 9], [15, 16, 9], [16, 17, 9], [17, 14, 9],
		]
 );
	
}


module _pyraField(xsize, ysize, size, thick) {
	xcount = (xsize / size);
	ycount = (ysize / size);
	for (x = [ 0 : xcount]) {
		for (y = [ 0 : ycount]) {
			translate([x * size, y * size, 0]) _pyramid(size, thick, ((x + y) % 2));
		}
	}
}

module splitModel(cube, partcube, psize = 8, thick = 0.01) {
	xcount = floor(cube[0] / partcube[0]);
	ycount = floor(cube[1] / partcube[1]);
	zcount = floor(cube[2] / partcube[2]);

	if (zcount > 0) {
		for (i = [1 : zcount]) {
			translate([0, 0, i * partcube[2]]) _pyraField(cube[0], cube[1], psize, thick);
		}
	}
	if (ycount > 0) {
		for (i = [1 : ycount]) {
			translate([0, i * partcube[1], 0]) rotate([90, 0, 0]) _pyraField(cube[0], cube[2], psize, thick);
		}
	}
	if (xcount > 0) {
		for (i = [1 : xcount]) {
			translate([i * partcube[0], 0, 0]) rotate([0, -90, 0]) _pyraField(cube[2], cube[1], psize, thick);
		}
	}
}
