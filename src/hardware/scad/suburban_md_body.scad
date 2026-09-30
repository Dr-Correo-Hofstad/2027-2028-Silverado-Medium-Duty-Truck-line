// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: suburban_md_body.scad (2027 Suburban HD Extended Passenger Shell)
// Core Application: 3-Row Family Capsule Mated to Original 165" Long-Wheelbase Frame
// COMPLIANCE GATE: Maintains absolute 65mm lower open clearance for underbody armor
// Center Origin (0,0,0) = Mid-point of the Original 165-Inch Frame Baseline Rail Axis
// ====================================================================================

$fn = 100; // Parametric curve panel surface finish resolution

// --- Original 165" Wheelbase Constants (mm) ---
inch_to_mm         = 25.4;
original_wheelbase = 165.0 * inch_to_mm; // Maintained original 4191.00 mm frame length [INDEX]
body_outer_width   = 94.00 * inch_to_mm; // Sized to clear rear dually track boundaries [INDEX]
sheet_metal_thick  = 1.50;               // Heavy fleet-gauge stamped steel skin scale
suburban_height    = 1920.00;            // Full-size extended utility vertical profile

// Underbody Clearance Rule Compliance [INDEX]
UNDER_ARMOR_CLEARANCE_MM = 65.00;

module front_engine_cowl_clip() {
    echo("STAMPING 2027 SUBURBAN REINFORCED FRONT QUARTER CLIP");
    // Front clip wrapper surrounding the 1,850 hp Mega-Flux motor core [INDEX]
    color("DarkBlue") {
        difference() {
            translate([0, original_wheelbase/2 + 400, 350])
                cube([body_outer_width - 120, 1400, 750], center=true);
            translate([0, original_wheelbase/2 + 400, 350])
                cube([body_outer_width - 150, 1404, 730], center=true); // Internal engine cavity
                
            // LOWER PROFILE STANDOFF: Cuts base line to preserve armor installation room [INDEX]
            translate([0, original_wheelbase/2 + 400, -50])
                cube([body_outer_width, 1410, UNDER_ARMOR_CLEARANCE_MM * 3], center=true);
        }
    }
}

module three_row_passenger_vault() {
    echo("COMPILING THREE-ROW FAMILY REINFORCED CABIN CAPSULE");
    // Extended utility interior cabin cell spanning over the floor load-cell balancing pockets [INDEX]
    color("SlateGrey") {
        difference() {
            // Main horizontal extended body block
            translate([0, -200, suburban_height/2 - 100])
                cube([body_outer_width, original_wheelbase + 200, suburban_height], center=true);
            
            // Hollow inner cabin cockpit cave [Leaves room for 2016 fabric seat sets] [INDEX]
            translate([0, -200, suburban_height/2 - 100])
                cube([body_outer_width - 40, original_wheelbase + 180, suburban_height - 50], center=true);
                
            // LOWER CHASSIS STANDOFF OVERRIDE (Rule Compliance) [INDEX]
            translate([0, -200, -100])
                cube([body_outer_width + 10, original_wheelbase + 220, UNDER_ARMOR_CLEARANCE_MM * 3], center=true);
        }
    }
}

// --- Composite Suburban Super-Structure Instantiation ---
union() {
    front_engine_cowl_clip();
    three_row_passenger_vault();
}
