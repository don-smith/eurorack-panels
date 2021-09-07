include <panel_common.scad>

hp = 8;
surface_thickness = 0.5;
width = (width_1hp * hp) - wiggle_room_width;
left_column = width / 4 - 2;
middle_column = width / 2 - 3;
right_column = middle_column + left_column + 5;
row_one = 105;
row_two = 85;
row_three = 65;
row_four = 45;

// to ensure faces aren't coincident
epsilon = 0.01;
difference() {
  union() {
    face_plate(hp);
    translate([0, 0, -epsilon])
      panel_surface();
  }
  mounting_holes(width);

  // in
  hole(row_one, left_column, 6);
  hole(row_two, left_column, 6);
  hole(row_three, left_column, 6);
  hole(row_four, left_column, 6);

  // cv
  hole(row_one, middle_column, 6);
  hole(row_two, middle_column, 6);
  hole(row_three, middle_column, 6);
  hole(row_four, middle_column, 6);

  // mix
  hole(row_one, right_column, 6);
  hole(row_two, right_column, 6);
  hole(row_three, right_column, 6);
  hole(row_four, right_column, 6);

  // out
  hole(15, right_column, 6);
}

module hole (row, column, size) {
  translate([column, row, 0])
    hole_in_face_plate(size);
}

module recesses() {
  // The -0.5 and 1.0 ensure we're
  // cutting all the way through the surface
  translate([right_column - 3, 17, 1.5]) // top left
    cylinder(d=5, h=surface_thickness + 1.0);
  translate([right_column + 3, 17, 1.5]) // top right
    cylinder(d=5, h=surface_thickness + 1.0);
  translate([right_column - 3, 13, 1.5]) // bottom left
    cylinder(d=5, h=surface_thickness + 1.0);
  translate([right_column + 3, 13, 1.5]) // bottom right
    cylinder(d=5, h=surface_thickness + 1.0);
  translate([right_column - 5.5, 13, 1.5])
    cube([11, 4, 1.5]);
  translate([right_column - 3, 10.5, 1.5])
    cube([6, 9, 1.5]);

  translate([left_column - 2.5, row_one + 8, 2])
    linear_extrude(1)
      text("in", size=5);
  translate([middle_column - 3, row_one + 8, 2])
    linear_extrude(1)
      text("cv", size=5);
  translate([right_column - 5, row_one + 8, 2])
    linear_extrude(1)
      text("mix", size=5);
}

module panel_surface() {
  difference() {
    rotate([-90, 0, 0])
      translate([0, -thickness-surface_thickness, 0])
        cube([width, thickness+surface_thickness, panel_height]);
    recesses();
  }
}
