module hidden_box_cup(payload) {
    difference() {
        translate([0, 0, -0.5])
        cube([payload.x + 0.3, payload.y, 1], true);
        
        translate([-payload.x / 2 - 0.5, 0, -1])
        cube([1.5, payload.y - 29.4, 3], true);
    }
    
    translate([payload.x / 2 - 2, 0, -2])
    rotate([-90, 0, 90])
    linear_extrude(2)
    polygon([
        [-payload.y / 2 + 5, 0], 
        [-payload.y / 2 + 5, 4],
        [-payload.y / 2 + 10, 9],
        [payload.y / 2 - 10, 9],
        [payload.y / 2 - 5, 4],
        [payload.y / 2 - 5, 0],
    ]);
        
    translate([payload.x / 2 - 3, 0, -1])
    cube([2, payload.y, 2], true);

    translate([payload.x / 2 + 1.1, 0, -0.5])
    cube([2.1, payload.y - 14.1, 1], true);
    
    translate([-payload.x / 2 + 2, 0, -6])
    cube([2, payload.y, 10], true);
    
    hidden_box_cup_right(payload);
    
    mirror([0, 1, 0])
    hidden_box_cup_right(payload);
}

module hidden_box_cup_right(payload) {
    translate([-payload.x / 2 + 1, payload.y / 2 - 2, -11])
    cube([payload.x - 35, 2, 10]);
    
    translate([-payload.x / 2 + 56, payload.y / 2 - 2, -2])
    cube([31, 2, 1]);
    
    translate([payload.x / 2 - 10, -payload.y / 2 + 6 , -5.5])
    floor_button_hook();
    
    translate([payload.x / 2 - 10, -payload.y / 2 , -2])
    rotate([0, 90, 0])
    linear_extrude(6)
    polygon([[0, 0], [3, 0], [3, 0.5], [0, 3]]);
    
    translate([payload.x / 2 - 10, -payload.y / 2, -2])
    cube([6, 7, 1]);
}

module floor_button_hook() {
    translate([0, 1, 1])
    cube([6, 2, 3.5]);
    
    translate([0, -0.4, 0.5])
    cube([1, 3, 3]);
    
    translate([0, -0.4, 0.5])
    cube([6, 3.4, 1]);
}


difference() {
    !hidden_box_cup([100, 60, 50]);
    
    translate([-35, -23, -2])
    cube([65, 46, 4]);
}
