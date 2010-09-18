/*

RepRap Wade Extruder Mount #1

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

*/

mount_height = 5;
insulator_diameter = 17.2;
bolt_diameter = 4.7;

module wade_mount_base() {
	translate([0, 0, 0]) {
		union() {
			translate([5, 0, 0]) {
				cube([70, 20, mount_height], center=true);
			}

			translate([0, 8, 0]) {
				cube([20, 60, mount_height], center=true);
			}

			// insulator
			translate([0, 8, 0]) {
				cylinder(mount_height, insulator_diameter/2+4, insulator_diameter/2+4, center=true);
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
		translate([0, 8, 0]) {
			cylinder(mount_height+2, insulator_diameter/2, insulator_diameter/2, center=true);
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