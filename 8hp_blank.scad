include <panel_common.scad>

hp = 8;
surface_thickness = 0.5;
width = (width_1hp * hp) - wiggle_room_width;

// to ensure faces aren't coincident
epsilon = 0.01;
difference() {
  union() {
    face_plate(hp);
    translate([0, 0, -epsilon])
      panel_surface();
  }
  mounting_holes(width);
}

module panel_surface() {
  difference() {
    rotate([-90, 0, 0])
      translate([0, -thickness-surface_thickness, 0])
        color("black")
        cube([width, thickness+surface_thickness, panel_height]);
  }
}

module hole (row, column, size) {
  translate([column, row, 0])
    hole_in_face_plate(size);
}

