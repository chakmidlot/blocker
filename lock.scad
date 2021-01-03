


// range 1 to 4
secret = [4, 2, 3, 1, 2];

n_pins = len(secret);

box_h   = 6*n_pins + 18;// + 18;

$fn = 100;



module base() {
    difference() {
        union() {
            cylinder(h=6*n_pins + 6, r=12);

            translate([0, 0, 6*n_pins + 4]) cylinder(h=2, r1=12, r2=13);
        }

        translate([0, 0, -1]) cylinder(h=6*n_pins + 8, r=10.1);

        for (i = [0: n_pins - 1]) {
            translate([-2, 0, 5 + i * 6]) rotate([0, -90, 0]) cylinder(h=10, r=2.2);
        }

        translate([0, -2.6, 6*n_pins]) cube([20, 20, 10]);
    }

    difference() {
        translate([-5, 12.5, 0]) cube([47.9, 62.9, 4], true);

        translate([0, 0, -3]) cylinder(h=6, r=9);

        cylinder(h=6, r=10.1);
    }

    translate([-14, 30, 0])
    difference() {
        translate([-2, -2, 0]) cube([9, 10, 6*n_pins + 4]);
        translate([0, -30, -1]) linear_extrude(6*n_pins + 8) offset(0.1) projection() springs();
    }

    translate([13.9, 38.9, 0]) cube([4, 4, 10]);
    translate([-27.9, -17.9, 0]) cube([4, 4, 10]);
    translate([-27.9, 38.9, 0]) cube([4, 4, 10]);
    translate([13.9, -17.9, 0]) cube([4, 4, 10]);
}

module springs() {
    for (i = [0: n_pins-1]) {
        translate([0, 0, i * 6]) spring();
    }

    translate([0, 30, -2]) cube([2, 5, 6 * n_pins - 2]);

    translate([0, 32, -2]) cube([5, 2, 6 * n_pins - 2]);
}

module spring() {
    translate([0, 0, -2]) cube([2, 30, 4]);
    rotate([0, 90, 0]) spring_pin();
}

module spring_pin() {
    cylinder(h=7, r=1.5);
    cylinder(h=2, r=2);

    translate([0, 0, 7]) cylinder(h=0.5, r1=1.5, r2=0.5);
}

module stop_ring() {
    rotate([0, 0, -10])
    difference() {
        cylinder(h=5, r=16);

        translate([0, 0, -0.01]) cylinder(h=3, r=12.1);

        translate([0, 0, 1.01]) cylinder(h=2, r1=12.1, r2=13.1);

        translate([0, 0, -1]) cylinder(h=7, r=8);

        translate([-5, -5, -1]) cube([25, 25, 7]);
    }
}

module plug() {
    difference() {
        cylinder(h=6*n_pins + 6, r=10);

        translate([2, -1, -1]) cube([4, 4, 6*n_pins + 8]);

        translate([-6, -1, -1]) cube([9, 2, 6*n_pins + 8]);

        for (i = [0: n_pins-1]) {
            translate([0, 0, 5 + i * 6]) rotate([0, -90, 0]) cylinder(h=10, r=2.2);
        }
    }

    rotate([0, 0, -90]) translate([0, 12, 6*n_pins + 4]) cube([5, 8, 4], true);
}

function blade(v, x) =
    x < len(secret)
        ? concat(ridge(x), blade(v, x + 1))
        : v;

function ridge(x) = [
    [x * 6, 2 + secret[x]-1],
    [x * 6 + 2, 2 + secret[x]],
    [x * 6 + 4, 2 + secret[x]],
];

module key() {

    translate([2.1, -0.9, -3]) hull() {
        cube([3.8, 3.8, 6*n_pins + 7]);

        translate([0.55, 1, 6*n_pins + 7]) cube([2.8, 2.25, 1]);
    }

        // key blade
        translate([1, 0.9, 2])
        rotate([0, 0, 90])
        rotate([0, -90, 0])
        linear_extrude(1.8)
        polygon(concat([[-4, -2], [-4, 5]], blade([], 0), [[6*n_pins+2, -2]] ));

        // echo(concat([[-4, -2], [-4, 5]], blade([], 0), [[26, -2]] ));

    // head
    translate([0, -0.9, 0])
    rotate([270, 0, 0])
    difference() {
        linear_extrude(3.8) offset(2)
            polygon([
                [-10, 5], [-6, 5], [-6, 2], [5, 2],
                [5, 5], [12, 5], [10, 19], [-8, 19]
            ]);


        translate([0, 0, -0.1]) linear_extrude(4) offset(2)
            polygon([
                [5, 16], [-3, 16], [-4, 15], [6, 15]
            ]);

    }
}

module pins() {
    for (i = [0: n_pins - 1]) {
        translate([-6.8, 0, i * 6]) rotate([0, 90, 0]) pin(4 - secret[i]);
    }
}

module pin(h) {
    cylinder(h=h + 3.8, r=2, $fn=30);

    translate([0, 0, h + 3.8]) cylinder(h=0.5, r1=2, r2=1, $fn=30);

    translate([0, 0, -0.5]) cylinder(h=0.5, r1=1, r2=2, $fn=30);
}

module box() {
    difference() {
        cube([50, 65, box_h]);

        translate([2, 2, -1]) cube([46, 61, box_h - 1]);

        translate([1, 1, -1]) cube([48, 63, 3]);
    }

    translate([44, 17, 6*n_pins + -1.5])
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
            plug();
            base();
            translate([-14, 0, 5]) springs();
            translate([0, 0, 6*n_pins + 3]) stop_ring();
        }
        translate([-40, -40, -3]) cube([100, 40, 6*n_pins + 26]);
    }

    translate([-2.55, 0, 5]) pins();
    key();

    difference() {
        translate([-30, -20, 0]) box();
        translate([-40, -40, -3]) cube([50, 70, 6*n_pins + 26]);
    }
}

preview();


// *** print ***

// translate([70, 20, 6*n_pins + 6])
// rotate([0, 180, 90]) plug();

// translate([30, 20, 2]) base();

// translate([-10, -50, 0])
// rotate([0, 270, 0]) springs();

// translate([-70, -30, 5])
// rotate([0, 180, 0]) stop_ring();

// translate([35, -45, 7.3])
// rotate([180, 270, 0]) pins();

// translate([30, -25, 0.9])
// rotate([90, 0, 90]) key();

// translate([-10, 0, box_h])
// rotate([0, 180, 0]) box();

