$fn = 100;

secret = [1, 3, 2, 4];

module base(y) {
    
    difference() {
        union() {
            cylinder(30, 12, 12);
            
            translate([0, 0, 26])
            cylinder(4, 12, 12.5);
        }
        
        translate([0, 0, 27])
        cylinder(2, 11, 11);
        
        translate([0, 0, 29])
        cylinder(0.2, 11, 10);
        
        translate([0, 0, -1])
        cylinder(32, 10.1, 10.1);
        
        for (i = [0: 3]) {
            translate([-2, 0, 5 + i * 6])
            rotate([0, -90, 0])
            cylinder(10, 2.2, 2.2);
        }
        
        translate([0, -2.6, 5])
        rotate_extrude(angle=70)
        polygon([[0, 0], [0, 30], [20, 30], [20, 0]]);
        
    }
    
    difference() {
        translate([-2.5, y / 2 - 15, 0])
        cube([39, y, 2], true);
        
        translate([0, 0, -3])
        cylinder(6, 9, 9);        
    }
    
    translate([-14, 20.5, 0])
    difference() {
        translate([-2, -2, 0])
        cube([9, 10, 26]);
        
        translate([0, -20, -1])
        linear_extrude(32)
        offset(0.1)
        projection()
        springs();
    }
    
    //box hooks
    
    translate([-8, 30.5, 14])
    rotate([180, 90, 0])
    linear_extrude(4)
    polygon([[0, 0], [0, 2], [3, 2], [1, 0]]);
    
    translate([-4, -15, 14])
    rotate([0, 90, 0])
    linear_extrude(4)
    polygon([[0, 0], [0, 4], [5, 4], [1, 0]]);
    
    // enforcers
    rotate([0, 0, 23])
    translate([-1, 11, 0])
    cube([2, 11, 26]);
    
    rotate([0, 0, 220])
    translate([-1, 11, 0])
    cube([2, 4, 26]);
}

module springs() {
    for (i = [0: 3]) {
        translate([0, 0, i * 6])
        spring();
    }
    
    translate([0, 20, -2])
    cube([2, 5, 22]);
    
    translate([0, 22, -2])
    cube([5, 2, 22]);
}

module spring() {
    translate([0, 0, -2])
    cube([1, 20, 4]);
    rotate([0, 90, 0])
    spring_pin();
}

module spring_pin() {
    cylinder(7, 1.9, 1.9);
    cylinder(2, 2, 2);
    
    translate([0, 0, 7])
    cylinder(0.5, 1.9, 0.5);
}

module stop_ring() {
    translate([0, 0, 27])
    rotate_extrude(angle=300)
    polygon([[7, 0], [7, 2], [11.5, 2], [11.5, 0]]);
}


module plug() {
    difference() {
        cylinder(25.8, 10, 10);
                
        translate([2, -1, -1])
        cube([4, 4, 32]);
        
        translate([-6, -1, -1])
        cube([9, 2, 32]);
        
        for (i = [0: 3]) {
            translate([0, 0, 4 + i * 6])
            rotate([0, -90, 0])
            cylinder(10, 2.2, 2.2);
        }    
    }
    
    rotate([0, 0, -90])
    translate([0, 14, 7])
    cube([5, 10, 4], true);
    
    translate([21, 0, 4.5])
    cube([4, 5, 9], true);
}

function blade(v, x) = 
    x < len(secret) 
        ? concat(ridge(x), blade(v, x + 1))
        : v;

function ridge(x) = [
    [x * 6, 2 + secret[x]],
    [x * 6 + 2, 2 + secret[x]],
    [x * 6 + 4, 2 + secret[x] - 1],
];

module key() {
    mirror([0, 0, 1]) {
        translate([2.1, -0.9, -1])
        difference() {
            cube([3.8, 3.8, 31]);
            
            translate([-2.5, 0, -1])
            rotate([0, 50, 0])
            cube([3, 5, 3]);
            
            translate([2.5, 0, -1])
            rotate([0, 40, 0])
            cube([3, 5, 3]);
            
            translate([-1, -1.7, -4.2])
            rotate([55, 0, 0])
            cube([5, 5, 3]);
            
            translate([-1, 3.8, -4])
            rotate([50, 0, 0])
            cube([5, 5, 3]);
        }
        
        // key blade
        translate([1, 0.9, 4])
        rotate([0, 0, 90])
        rotate([0, -90, 0])
        linear_extrude(1.8)
        polygon(concat([[-4, -2]], blade([], 0), [[26, 5], [26, -2]]));
        
        // head
        
        translate([0, 2.9, 0])
        rotate([90, 0, 0])
        difference() {
            linear_extrude(3.8)
            offset(2)
            polygon([
                [-10, 33], [-6, 33], [-6, 30], [5, 30],
                [5, 33], [12, 33], [10, 47], [-8, 47]
            ]);
            
            
            translate([0, 0, -0.1])
            linear_extrude(4)
            offset(2)
            polygon([
                [5, 44], [-3, 44], [-4, 43], [6, 43]
            ]);
            
        }
    }
}

module pins() {
    for (i = [0: len(secret) - 1]) {
        translate([-6.8, 0, - i * 6])
        rotate([0, 90, 0])
        pin(4 - secret[i]);
    }
}

module pin(h) {
    cylinder(h + 3.8, 2, 2);
    
    translate([0, 0, h + 3.8])
    cylinder(0.5, 2, 1);
    
    translate([0, 0, -0.5])
    cylinder(0.5, 1, 2);
    
}

module box() {
    difference() {
        cube([50, 65, 60]);
        
        translate([2, 2, -1])
        cube([46, 61, 59]);
        
        translate([1, 1, -1])
        cube([48, 63, 3]);
    }
    
    translate([44, 17, 22.5])
    box_shelf();
    
    
}

module box_shelf() {
    cube([5, 13, 3]);
    
    rotate([90, 0, 0])
    linear_extrude(3)
    polygon([[0, 0], [4, 0], [4, 9], [0, 4]]);
    
    translate([0, 16, 0])
    rotate([90, 0, 0])
    linear_extrude(3)
    polygon([[0, 0], [4, 0], [4, 9], [0, 4]]);
}


module preview() {
    difference() {
        union() {
            plug(); // *** print ***
            base(); // *** print ***

            translate([-14, 0, 5])
            springs(); // *** print ***

            translate([0, 0, 27])
            stop_ring(); // *** print ***
            
        }
        translate([-40, -40, -3])
        cube([100, 40, 50]);
    }

    translate([-2.55, 0, 23])
    pins(); // *** print ***

    translate([0, 0, 28])
    key(); // *** print ***

    difference() {
        translate([-30, -20, 0])
        box(); // *** print ***
        
        translate([-40, -40, -3])
        cube([50, 70, 50]);
    }
}

module assembled_lock(y) {    
    translate([10, 15, 11])
    rotate([0, 180, 0])
    {
        base(y);   
        
        translate([0, 0, 1])
        rotate([0, 0, 0])
        plug();
        
        stop_ring();
        
        translate([-3, 0, 23])
        pins();
    }
    
    translate([24, 15, 6])
    rotate([0, 180, 0])
    springs();
    
}

difference() {
    assembled_lock(70);
    
    translate([10, -10, -20])
    cube([30, 25, 40]);
}