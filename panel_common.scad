thickness = 2;
panel_height = 128.5;
width_1hp = 5.08; // 5.08 == 0.2" (from the HP spec)
wiggle_room_width = 0.3; // so modules don't fit too tightly

hole_width = 5;
hole_diameter = 3.2;
hole_height_edge = 3; // distance from hole center to panel edge
hole_width_edge = 7.5; // distance from hole center to panel edge

// increase resolution of the cylinders
$fs = 0.1;

module face_plate(hp) {
  width = (width_1hp * hp) - wiggle_room_width;

  difference() {
    rotate([-90, 0, 0])
      translate([0, -thickness, 0])
        color("yellow")
        cube([width, thickness, panel_height]);
    mounting_holes(width);
  }
}

module hole_in_face_plate(diameter) {
  // The -0.5 and 1.0 ensure we're
  // cutting all the way through the panel
  translate([0, 0, -0.5])
    cylinder(d=diameter, h=thickness + 1.0);
}

module mounting_hole(diameter, width) {
  spacing = (width - diameter) / 2;
  union() {
    translate([-spacing, 0, 0])
      hole_in_face_plate(diameter);

    translate([spacing, 0, 0])
      hole_in_face_plate(diameter);

    // The -0.5 and 1.0 ensure we're
    // cutting all the way through the panel
    translate([-spacing, -diameter/2, -0.5])
      cube([width - diameter, diameter, thickness + 1.0]);
  }
}

module mounting_holes (panel_width) {
  // top left
  translate([hole_width_edge, panel_height - hole_height_edge, 0]) {
    mounting_hole(hole_diameter, hole_width);
  }

  // bottom left
  translate([hole_width_edge, hole_height_edge, 0]) {
    mounting_hole(hole_diameter, hole_width);
  }

  // top right
  translate([panel_width - hole_width_edge, panel_height - hole_height_edge, 0]) {
    mounting_hole(hole_diameter, hole_width);
  }

  // bottom right
  translate([panel_width - hole_width_edge, hole_height_edge, 0 ]) {
    mounting_hole(hole_diameter, hole_width);
  }
}
