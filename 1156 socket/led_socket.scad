sides = 100;
socket_diameter = 27; // mm
socket_depth = 10;

notch_start = 5; // mm
notch_end = 8; // mm
big_notch_width = 12; //mm
reg_notch_width = 4; // mm

module socket_negative(){
    union(){
        translate([0,0, 1]) cylinder(d=socket_diameter, h=socket_depth, $fn=sides); //socket
        translate([0,0, -3])  cylinder(d=socket_diameter+5, h=10, $fn=sides);  // notch ring

        translate([0,0,-1]) sector(12, socket_diameter+5, 0, 20);
        translate([0,0,-1]) sector(12, socket_diameter+5, 180, 200);
        translate([0,0,-1]) sector(12, socket_diameter+5, 90, 110);
        translate([0,0,-1]) sector(12, socket_diameter+5, 255, 305);
        
        translate([0,0, -9])  cylinder(d=socket_diameter+5, h=10, $fn=sides);  //for space in front
        //#translate([0,0, 8])  cylinder(d=socket_diameter+5, h=10, $fn=sides);  //for space in the back
    }
}


module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d, $fn=sides);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d, $fn=sides);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}    


module socket(){
    difference(){
      translate([0,0, 0])  cylinder(d=60, h=10, $fn=sides);  //for space in front
      socket_negative();
    }
}


socket();

