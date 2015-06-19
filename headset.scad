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


render = "both";	// options are "face", "front", "both", or "strap"


make_printable = false;









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
		//front
		module nose(){
				translate([0,0,-phone_width/2]) scale([nose_width,nose_depth*2,nose_height*2]) sphere(d=1, $fn=50);;
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