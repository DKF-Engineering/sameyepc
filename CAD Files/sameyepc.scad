
minolta_af_ffd = 44.5; // flange focal distance, see https://en.wikipedia.org/wiki/Flange_focal_distance
external_ring_height = 2.2; // ring from Minolta AF extension tube
external_ring_hole_dia = 1.8/2; // ring from Minolta AF extension tube
external_ring_hole_circle_dia = 57.0; // ring from Minolta AF extension tube
external_ring_lock_width = 8.0; // bajonet lock from Minolta AF extension tube
lock_button_length = 10;
lock_button_width = 7;

minolta_af_outer_dia = 64;
minolta_af_inner_dia = 51; // Minolta AF inner diameter
entrance_aperture = minolta_af_inner_dia;

TS_filter_drawer_height = 6.1;
TS_filter_drawer_width = 55.7;
TS_filter_drawer_depth = TS_filter_drawer_width;

eyepiece_front_focus = 20;

//--------------------------------------------------------------------------------------------------
front_flange_height = 7.0; // similar to Minolta AF adapter
rear_flange_dia = 61.0; // similar to Sony E mount

ffd_tolerance = 2.0;
overall_length = minolta_af_ffd - external_ring_height - ffd_tolerance;

drawer_tolerance = 0.5;
drawer_h = TS_filter_drawer_height;
drawer_w = TS_filter_drawer_width;
drawer_d = TS_filter_drawer_depth;

cage_wall = 4.0;
cone_height = 15;
optical_aperture = 25.4*1.25; // 1.25"

eyepiece_outer_dia = optical_aperture + 2*cage_wall;

cage_depth = drawer_w+1*cage_wall;
cage_width = drawer_w+2*cage_wall;

rear_flange_height = overall_length - (front_flange_height + cone_height);

// use high tessellation on the cylinders to get a good fit
$fn = 300;

//--------------------------------------------------------------------------------------------------

union()
{
 // front adapter:
 rotate([0,0,90])
 translate([0,0,cone_height+front_flange_height/2])
 difference()
 {
      difference() // lock
      {
         difference()
         {
            difference() // flange ring
               {
                  cylinder(d=minolta_af_outer_dia, h=front_flange_height, center=true);
                  cylinder(d=entrance_aperture, h=front_flange_height+0.1, center=true);
               }
            union() // 3 mounting holes for external ring
               {
                  for(i=[0:2])
                  {
                     rotate([0,0,i*120])
                     translate([external_ring_hole_circle_dia/2,0,0])
                     cylinder(d=external_ring_hole_dia, h=front_flange_height+0.1, center=true);
                  }
               }
         }
         rotate([0,0,-90])
         union() // lock button
         {
            translate([minolta_af_inner_dia/2+0.6+lock_button_length/2,0,front_flange_height/2-(1.5-0.1)/2])
            cube([lock_button_length,lock_button_width,1.5+0.1], center=true);
            translate([external_ring_hole_circle_dia/2,0,0])
            cylinder(d=1.1, h=front_flange_height, center=true);
            translate([external_ring_hole_circle_dia/2,0,front_flange_height/2-(1.5)/2-1])
            cylinder(d=2.0, h=1, center=true);
         }
     }
   rotate([35,90,0])
   translate([0,0,minolta_af_outer_dia/2-1/2])
   cylinder(d=1.5, h=1+0.1, center=true);
}

 // filter cage:
 rotate([0,0,90])
 rotate([0,0,90])
 translate([0,0,(cone_height)/2])
 difference()
 {
 difference()
 {
  cylinder(d1=eyepiece_outer_dia, d2=minolta_af_outer_dia, h=cone_height+0.1, center=true);
 
  cylinder(d1=optical_aperture, d2=minolta_af_inner_dia, h=cone_height+0.1, center=true);
 }
 }

difference()
{
 // eyepiece adapter:
 translate([0,0,-rear_flange_height/2])
 difference()
 {
  cylinder(d=eyepiece_outer_dia, h=rear_flange_height, center=true);
  cylinder(d=optical_aperture, h=rear_flange_height+0.1, center=true);
 }
 for(i=[0:2])
 {
  rotate([0,0,i*120])
  translate([eyepiece_outer_dia/4,0,-rear_flange_height*3/4])
  rotate([0,90,0])
  cylinder(d=3, h=eyepiece_outer_dia/2+0.1, center=true);
 }
}
}


