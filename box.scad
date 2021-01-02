use <hidden_layer.scad>;

payload = [100  , 70, 50];

use <lock.scad>;

$fn = 100;

module housing() {
    difference() {
        translate([payload.x / 2 + 20.5, 0, payload.z / 2 + 1])
        cube([payload.x + 41, payload.y + 4, payload.z + 2], true);
        
        translate([payload.x / 2 + 20.5, 0, payload.z / 2 + 2.5])
        cube([payload.x + 37, payload.y, payload.z + 1], true);
        
        housing_cuts_right();
        
        mirror([0, 1, 0])
        housing_cuts_right();
        
        translate([0, - payload.y / 2 - 2, 0])
        cup_rails();
        
        translate([payload.x + 40, 0, payload.z + 5])
        cube([4, payload.y, 10], true);
    }
    
    guides_right();
    mirror([0, 1, 0])
    guides_right();
    
    hidden_floor_latch_holder();
    mirror([0, 1, 0])
    hidden_floor_latch_holder();
    
    // lock room
    translate([payload.x + 6, -payload.y / 2 + 45.5, 0])
    cube([33, 2, payload.z]);
    
    translate([payload.x + 6, -payload.y / 2 + 42.5, 0])
    cube([2, 8, payload.z]);
    
    translate([payload.x + 8, 2, payload.z - 10])
    lock_room();
}

module housing_cuts_right() {
    translate([1.3, - payload.y / 2, 11.8])
    cube([2, 15, 1.5]);
    
    translate([10, 0, 0])
    cup_hang_pocket();
    
    translate([payload.x - 30, 0, 0])
    cup_hang_pocket();
}

module cup_hang_pocket() {
    translate([0, - payload.y / 2 - 1, payload.z - 2])
    cube([20, 3, 5]);
    
    translate([30, - payload.y / 2 - 1, payload.z - 2])
    difference() {
        rotate([0, -90, 0])
        linear_extrude(15)
        polygon([[0, 0], [1, 0], [3, 2], [0, 2]]);
        
        translate([-1.5, -0.2, 0])
        cylinder(4, 0.5, 0.5);
    }
}

module guides_right() {
    translate([payload.x + 2, payload.y / 2 - 7, 11])
    cube([2, 8, payload.z - 11]);

    translate([payload.x + 6, payload.y / 2 - 7, 11])
    cube([2, 8, payload.z - 11]);
    
    translate([payload.x + 5, 0, 4.9])
    cube([6, payload.y, 5.9], true);
    
    translate([payload.x + 7, 0, 9.8])
    cube([2, payload.y - 12, 4], true);
    
    translate([payload.x + 3, 0, 9.8])
    cube([2, payload.y - 12, 4], true);
}

module hidden_floor_latch_holder() {
    translate([payload.x + -30, -payload.y / 2, 6]) {
        translate([0, 0, 2])
        cube([5, 2, 3]);
        
        translate([0, 3.5, 2])
        cube([5, 2, 3]);
        
        translate([-0.5, 0, 2])
        cube([2, 5.5, 3]);
        
        translate([-0.5, 0, -4])
        cube([8.5, 5.5, 6]);
    }
}

module wall_guides_right() {
    
}

module cup_rails() {
    translate([-1, 2, payload.z - 1])
    cube([4, payload.y, 10]);
    
    translate([-1, 1, payload.z + 1])
    cube([payload.x + 3, 2, 2]);
    
    translate([-1, payload.y + 1, payload.z + 1])
    cube([payload.x + 3, 2, 2]);
    
    translate([-1, 2, payload.z - 2])
    cube([2, payload.y, 2]);
}

module top_hook() {
    difference() {
        rotate([0, 90, 0])
        linear_extrude(10)
        polygon([[0, 0], [0, 1], [1, 0]]);
        
        translate([0, 0, 0])
        rotate([0, 90, 15])
        linear_extrude(10)
        polygon([[0, 0], [0, 1], [1, 0], [1, -1]]);
    }
        
}

module lock_room() {
    translate([5, - payload.y / 2 - 2, 0])
    lock_rails();
    
    translate([13, - payload.y / 2 + 43.5, 0])
    mirror([0, 1, 0])
    lock_rails();
}


module floor_latch() {
    translate([-3, 2, 0])
    cube([32, 1.5, 2.8]);
    
    translate([19, 3.5, 1.1])
    rotate([0, -90, 0])
    linear_extrude(3)
    polygon([[0, 0], [1.7, 0], [0.3, 1.4], [0, 1.4]]);
    
    translate([-3, -2, 0])
    cube([3, 4, 2.8]);
    
    translate([-6, -0, 0])
    cube([4, 1.5, 2.8]);
}

module barrier() {
    difference() {
        translate([0, 0.25, 6.5])
        cube([1.9, payload.y - 0.5, payload.z - 11]);
        
        translate([-1,  12, payload.z - 13])
        cube([5, 20, 5]);
        
        translate([-1,  24, payload.z - 13])
        cube([5, 10, 10]);
    }
    
    translate([0, 9, 3.5])
    cube([1.9, payload.y - 18, 3]);
}

module top() {
    translate([payload.x / 2 + 1, 0, 1.5])
    cube([payload.x + 2, payload.y + 2, 1], true);
    
    translate([payload.x / 2 + 1, 0, 0.5])
    cube([payload.x + 2, payload.y, 1], true);
    
    translate([1, 0, -0.5])
    cube([2, payload.y, 1], true);
    
    translate([0.5, 0, -1.5])
    cube([1, payload.y, 1], true);
    
    top_hooks();
    
    // lock_hook
    translate([payload.x - 4, -payload.y / 2 + 8, -4])
    cube([6, 4.5, 4]);
    
    intersection() {
        translate([payload.x + 1, -payload.y / 2 + 8, 0])
        rotate([-90, 0, 0])
        linear_extrude(14)
        polygon([[-1, 0], [1, 0], [3, 2], [3, 4], [-1, 4]]);
        
        translate([payload.x + 23, -payload.y / 2 + 14, -4])
        rotate([0, 0, 150])
        rotate_extrude(angle=50)
        polygon([[23, 0], [23, 4], [18, 4], [18, 0]]);
    }
}

module top_hooks() {
    translate([30, -payload.y / 2 - 1, 0])
    top_hook();
    
    translate([payload.x - 10, -payload.y / 2 - 1, 0])
    top_hook();
    
    mirror([0, 1, 0]) {
        translate([30, -payload.y / 2 - 1, 0])
        top_hook();
        
        translate([payload.x - 10, -payload.y / 2 - 1, 0])
        top_hook();
    }
}

module top_hook() {
    difference() {
        rotate([0, 90, 0])
        linear_extrude(9.9)
        polygon([[1, 0], [2, 0], [2, 2], [0, 3], [0, 1]]);
        
        translate([8.5, -0.2, -3])
        cylinder(3, 0.6, 0.6);
        
        translate([8.5, -1.8, -3])
        cube([5, 2, 3]);
    }
}

module lock_rails() {
    translate([8, 0, 0])
    cube([2, 2, 10]);
    
    translate([14, 0, -4])
    cube([2, 2, 14]);
    
    translate([4, 0, 0])
    cube([6, 2, 2]);
    
    translate([4, 0, -5])
    cube([12, 2, 2]);
    
    translate([4, 0, -5])
    cube([2, 2, 6]);
    
    translate([4, 0, -5])
    rotate([0, 90, 0])
    linear_extrude(12)
    polygon([[0, 0], [2, 0], [0, 2]]);
    
    translate([5, 0, 0])
    rotate([0, 90, 0])
    linear_extrude(5)
    polygon([[0, 0], [2, 0], [0, 2]]);
}

difference() {
intersection() {
    union() {
        housing();
        
        
        translate([payload.x - 22, -payload.y / 2 + 2, 8])
        floor_latch();
        
        mirror([0, 1, 0])
        translate([payload.x - 22, -payload.y / 2 + 2, 8])
        floor_latch();
        
        translate([payload.x / 2 + 1.8, 0, 13])
        hidden_box_cup(payload);
        
        translate([payload.x + 4, -payload.y / 2, 4.5])
        barrier();
        %
        translate([0, 0, payload.z])
        top();
        
        translate([payload.x + 9, -payload.y / 2, payload.z - 10])
        assembled_lock(payload.y);

    }
    

//    translate([-1, - payload.y / 2 - 3, -1])
//    cube([130, 30, 60]);

    translate([-1, -payload.y / 2 + 10, -1])
    cube([payload.x + 35 , payload.y, payload.z + 5]);
    
//    translate([-1, -1, 35])
//    cube([97, 90, 30]);
    
//    translate([payload.x, -1, -1])
//    cube([97, 100, 58]);
}

//translate([10, 10, -1])
//    cube([70, 38, 10]);

//translate([95, -1, -1])
//    cube([50, 100, 80]);

//translate([80, -1, -1])
//    cube([100, 20, 80]);
}
