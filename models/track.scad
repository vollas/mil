// Parameters
pc_width = 82;
pc_height = 82;
pc_depth = 40;
bracket_thickness = 5;
flange_width = 10;
din_clip_width = 15;
din_clip_height = 10;
cable_clearance = 20;

// Main bracket body
module bracket_body() {
    cube([pc_width + 2*flange_width, pc_height + 2*flange_width, bracket_thickness]);
}

// Cutout for C6015
module pc_cutout() {
    translate([flange_width, flange_width, -1])
        cube([pc_width, pc_height, bracket_thickness + 2]);
}

// Side flanges
module side_flanges() {
    translate([0, 0, 0])
        cube([flange_width, pc_height + 2*flange_width, bracket_thickness]);
    translate([pc_width + flange_width, 0, 0])
        cube([flange_width, pc_height + 2*flange_width, bracket_thickness]);
}

// DIN rail clips (simplified)
module din_clips() {
    translate([flange_width + 10, -din_clip_height, 0])
        cube([din_clip_width, din_clip_height, bracket_thickness]);
    translate([flange_width + pc_width - 25, -din_clip_height, 0])
        cube([din_clip_width, din_clip_height, bracket_thickness]);
}

// Cable routing clearance
module cable_clearance_zone() {
    translate([flange_width + pc_width - cable_clearance, flange_width + pc_height, 0])
        cube([cable_clearance, cable_clearance, bracket_thickness]);
}

// Full assembly
difference() {
    union() {
        bracket_body();
        side_flanges();
        din_clips();
    }
    pc_cutout();
    cable_clearance_zone();
}
