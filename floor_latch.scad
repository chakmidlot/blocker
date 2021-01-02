module latch() {
    translate([-6, 1, 0])
    cube([34, 1.5, 2.8]);
    
    
    translate([19, 2.5, 1.1])
    rotate([0, -90, 0])
    linear_extrude(3)
    polygon([[0, 0], [1.7, 0], [0.3, 1.4], [0, 1.4]]);
    
    translate([-1, -3, 0])
    cube([3, 4, 2.8]);
}

module cup() {
    latch();
}

module base() {
    cube([5, 7, 2.8]);
}

module preview() {
    latch();
}



%
base();

translate([8, 3, 0])
preview();