/*

RepRap Wade Extruder Mount #2

Tony Buser <tbuser@gmail.com>
http://tonybuser.com
http://replimat.com

Improvements:

	* mounted horizontally to improve clearance
	* prevents motor collision on left side at 0mm X above ~50mm Z
	* now only collides frame on right if you go past 160mm X and above 90mm Z
	* hot end now centered in carriage
	* can now be removed from carriage without having to dissasemble first
	* lifts makerbot sized hot end to increase max Z by 5mm
	* also supports grooved insulators
*/

// type of insulator barrel
insulator_type = "groove"; // standard, groove

mount_height = 5;

// standard is 16, make it larger for inaccurate printers
insulator_diameter = 17.2;

// standard is 4, make it larger for inaccurate printers
bolt_diameter = 4.7;

// standard is 12, make it larger for inaccurate printers
groove_diameter = 13.2;

module wade_mount_base() {
	translate([0, 0, 0]) {
		union() {
			translate([7, 0, 0]) {
				cube([74, 20, mount_height], center=true);
			}

			translate([0, 8, 0]) {
				cube([20, 60, mount_height], center=true);
			}

			// insulator curve
			translate([0, 8, 0]) {
				cylinder(mount_height, insulator_diameter/2+6, insulator_diameter/2+6, center=true);
			}

			// front tab curve
			translate([0, -8, 0]) {
				cylinder(mount_height, insulator_diameter/2+6, insulator_diameter/2+6, center=true);
			}

			// left wade mounting hole
			translate([-20-2, 8, 0]) {
				cylinder(mount_height, bolt_diameter/2+2, bolt_diameter/2+2, center=true);
			}


			// right wade mounting hole
			translate([30-2, 8, 0]) {
				cylinder(mount_height, bolt_diameter/2+2, bolt_diameter/2+2, center=true);
			}

		}
	}
}

module wade_mount() {
	difference() {
		wade_mount_base();

		// insulator
		if (insulator_type == "groove") {
			// sloped hole
			translate([0, 8, -2]) {
				cylinder(mount_height+1, insulator_diameter/2+1, groove_diameter/2, center=true);
			}

			// to create lip
			translate([0, 8, 0]) {
				cylinder(mount_height+2, groove_diameter/2, groove_diameter/2, center=true);
			}

			// cutout so it can flex and pop in
			translate([-1, 8, -mount_height/2-1]) {
				rotate([0, 0, -45]) cube([groove_diameter, insulator_diameter, mount_height+2], center=false);
			}
		} else {
			translate([0, 8, 0]) {
				cylinder(mount_height+2, insulator_diameter/2, insulator_diameter/2, center=true);
			}
		}

		// back mounting hole
		translate([0, 25+8, 0]) {
			cylinder(mount_height+2, bolt_diameter/2, bolt_diameter/2, center=true);
		}

		// front mounting hole
		translate([0, -25+8, 0]) {
			cylinder(mount_height+2, bolt_diameter/2, bolt_diameter/2, center=true);
		}

		// front mounting hole inset
		translate([0, -25+8, mount_height-3.5]) {
			cylinder(mount_height, (bolt_diameter+3)/2, (bolt_diameter+3)/2, center=true);
		}
		
		// left wade mounting hole
		translate([-20-2, 8, 0]) {
			cylinder(mount_height+2, bolt_diameter/2, bolt_diameter/2, center=true);
		}


		// right wade mounting hole
		translate([30-2, 8, 0]) {
			cylinder(mount_height+2, bolt_diameter/2, bolt_diameter/2, center=true);
		}
	}
}

translate([0, 0, mount_height/2]) wade_mount();