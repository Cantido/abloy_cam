include <fillet.scad>

// relevant lock dimensions (in mm)

caliper_resolution = 0.02;

shaft_width = 6.90;
shaft_length = 7.70;
shaft_od = 8.00;
nut_width = 10.92;
nut_od = 12.54;
nut_thickness = 4.90;

// customizeable dimensions (mm)
cam_base_od = 15;
cam_base_thickness = 3.20;
cam_hole_width = 7.30;
cam_od = 8.59;
cam_offset = 7;
cam_length = 40;


module base() {
    cylinder(h = cam_base_thickness, d = cam_base_od);
}

module cam() {
  difference() {
    translate([cam_offset, 0, 0]) cylinder(h = cam_length, d = cam_od);
    translate([0.5, 0, cam_base_thickness]) resize([0, 0, nut_thickness + shaft_length - cam_base_thickness]) nut();
  }
}




module nut() {
  translate([0, 0, 0.5 * nut_thickness]) cube([nut_od, nut_od, nut_thickness], center=true);
}

module shaft() {
  scale([1.05, 1.05, 1.05])
  cube([shaft_width, shaft_width, shaft_length], center=true);
}

module body() {
    hull() {
      base();
      translate([cam_offset, 0, 0]) cylinder(d = cam_od, h = cam_base_thickness);
    }
    cam();
}

difference() {
  body();
  shaft();
}

// fillets
translate([cam_offset, 0, cam_base_thickness]) rotate([0, 45, 0]) cube([1, cam_od-0.5, 2], center=true);
