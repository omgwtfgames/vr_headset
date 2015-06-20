     ///////////////////////////////////////////////////////////
    //////// This project was done by Benjamin Engel  ///////////
   //////// Twitter @ben_beezy ///////////////////////////////
  //////// Google benengel94  ///////////////////////////////
 //////// github benbeezy //////////////////////////////////
///////////////////////////////////////////////////////////


  ////////////////////////////////////////////////////////
 ///////////////// EVERYTHING IS IN MM /////////////////
////////////////////////////////////////////////////////



//phone settings
phone_height = 159.3;
phone_width = 83;
phone_thickness = 5; //this is only if you want the printed bands


//face_settings
face_curve = phone_height/2;
eye_gap = 68;  //ipd
nose_width = 40;
nose_depth = 30;
nose_height = 30;

//print settings
wall_thickness = 3;
layer_height=.5;

//strap settings
stretch_strength = 3;

//lense settings
lense_diamiter = 50;
lense_thickness = 15;
outer_thickness= 2;
focal_length= 45;
face_plate_thickness = 5;

//label it
your_name = "Benjamin";
phone_name = "Nexus 6";


render = "front";	// options are "face", "front", "both", or "strap"


make_printable = false;

//EXTRAS

//head strap
head_strap_mount = true;
head_strap_width = 50;
head_strap_mount_thickness = 10;
head_strap_thickness = 2.5;


//magnet
add_magnet = true; //true or false, this will work like a click in google cardboard apps
magnet_gap = 2;
innder_magnet_diamiter = 19;
outer_magnet_diamiter = 19; 
outer_magnet_thickness = 5;
//use whatever magnets you want, make sure to take print error into account if your printer isnt printing right








//oporations

module front() {
	difference(){
		front_added();
		front_taken();
	}
}

module face() {
	difference(){
		face_added();
		face_taken();
	}
}

//functions

if (render=="front" || render=="both") {
	if (make_printable == true){
		rotate([90,0,0]) front();
	}
	else{
		front();
	}
}

if (render=="face" || render=="both") {
	if (make_printable == true){
		rotate([-90,0,0]) face();
	}
	else{
		face();
	}
}

if (render=="strap"){
			strap();
}


//modules
		module head_strap_mount(){
			module taken(){
				translate([(phone_height/2)+wall_thickness+head_strap_thickness,head_strap_mount_thickness/2,0]) cube([head_strap_thickness,50,head_strap_width], center=true);
				translate([(phone_height/2)+wall_thickness+head_strap_thickness*3,head_strap_mount_thickness/2,0]) cube([head_strap_thickness,50,head_strap_width], center=true);
			}
			module added(){
				translate([(phone_height/2)+wall_thickness+head_strap_thickness*2.5,head_strap_mount_thickness/2,0]) cube([head_strap_thickness*5,head_strap_mount_thickness,head_strap_width+head_strap_mount_thickness], center=true);
			}
			module head_strap_fin(){
				difference(){
					added();
					taken();
				}
			}
			head_strap_fin();
			mirror([1,0,0]) head_strap_fin();
		}
		module nose(){
				translate([0,0,-phone_width/2]) scale([nose_width,nose_depth*2,nose_height*2]) sphere(d=1, $fn=50);;
		}
		module outside_magnet(){
			translate([phone_height/2,focal_length/2,outer_magnet_diamiter/2])difference(){
				hull(){
					sphere(d=outer_magnet_diamiter+4);
					translate([0,0,-outer_magnet_diamiter]) sphere(d=outer_magnet_diamiter+4);
				}
				translate([outer_magnet_diamiter/2-outer_magnet_thickness,0,0]) hull(){
					rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
					translate([0,0,-outer_magnet_diamiter]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
				}
				translate([-100,-50,-50]) cube([100,100,100]);
				translate([-50+outer_magnet_diamiter/2-outer_magnet_thickness-magnet_gap,0,0]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
			}
		}
		
		module inner_magnet(){
			translate([phone_height/2,focal_length/2,outer_magnet_diamiter/2])
				translate([-50+outer_magnet_diamiter/2-outer_magnet_thickness-magnet_gap,0,0]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
		}
		
		module clip(){
			rotate([-90,0,0]) translate([0,-5,0]) difference(){
				rotate([45,0,0]) cube([10,50,5], center=true);
				translate([-25,-25,-50]) cube([50,50,50]);
				translate([-25,-50,-5]) cube([50,50,50]);
				translate([-25,5,0]) cube([50,50,50]);
			}
		}
		module strap(){
			difference(){
				cube([15,phone_width+focal_length*2+phone_thickness,layer_height*stretch_strength]);
				translate([2.5,2.5,-5])cube([10,10,10]);
				translate([2.5,(phone_width+focal_length*2)-7.5,-5]) cube([10,10,10]);
			}
		}
		module front_added(){
			translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([1,0,0]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([0,0,1]) mirror([1,0,0]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([0,0,1]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			
			translate([0,focal_length/2,0]){
				cube([phone_height+wall_thickness*2,focal_length,phone_width+wall_thickness*2], center=true);
			}
			if (add_magnet == true){
				outside_magnet();
			}
			if (head_strap_mount == true){
				head_strap_mount();
			}
					
		}
		module front_taken(){
					nose();
			translate([0,(focal_length/2)+3,0]){
				translate([phone_height/4,0,0]) cube([phone_height/2-wall_thickness/2,focal_length,phone_width], center=true);
				mirror([1,0,0]) translate([phone_height/4,0,0]) cube([phone_height/2-wall_thickness/2,focal_length,phone_width], center=true);
				
				
				translate([phone_height/4,-15,0]) rotate([90,0,0]) cylinder(h=focal_length, d=phone_width-10);
				translate([-phone_height/4,-15,0]) rotate([90,0,0]) cylinder(h=focal_length, d=phone_width-10);
				translate([-phone_height/2,0,phone_width/2+wall_thickness-2]) linear_extrude(height=3) {
					text(phone_name);
				}
			}
			if (add_magnet == true){
				inner_magnet();
			}
		}
		
		//face
		module face_added(){
			translate([0,-focal_length/2,0]){
				cube([phone_height+wall_thickness*2,focal_length,phone_width+wall_thickness*2], center=true);
			}
		}
		module face_taken(){
					nose();
			translate([0,(-focal_length/2)-face_plate_thickness,0]) cube([phone_height,focal_length,phone_width], center=true);
			translate([0,-face_curve-face_plate_thickness,-phone_width/2-wall_thickness-1]) cylinder(h=phone_width*2, r=face_curve);
			translate([eye_gap/2,(-lense_thickness/2)-(face_plate_thickness/2),0]) lense();
			mirror([1,0,0]) translate([eye_gap/2,(-lense_thickness/2)-(face_plate_thickness/2),0]) lense();
			translate([-phone_height/2,-10,phone_width/2+wall_thickness-2]) linear_extrude(height=3) {
					text(your_name);
				}
		}
		
		//lenses
		module lense(){
			hull(){
				translate([0,lense_thickness/2,0]) scale([lense_diamiter-3,lense_thickness,lense_diamiter-3]) sphere(d=1, $fn=50);
				translate([0,(lense_thickness/2)-outer_thickness/2,0]) rotate([-90,0,0]) cylinder(d=lense_diamiter, h=outer_thickness, $fn=50);
			}
		}