// ====================================================================================
// REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
// Subsystem: van_md_shelving.scad (OtterBox Commercial Tool Racking Matrix)
// Core Application: Dual-Density Sealed Fleet Shelving Units & Bin Compartments
// Center Origin (0,0,0) = Mid-point of the Rear Cargo Floor Plane Axis
// ====================================================================================

$fn = 80; // High-precision panel molding and rack grid resolution

// --- OtterBox Shelving Dimensional Constants (mm) ---
inch_to_mm         = 25.4;
rack_depth         = 16.0 * inch_to_mm;  // 406.40 mm deep tools/parts shelves
rack_length        = 1800.00;          // Extended warehouse shelf storage run depth
rack_height        = 1400.00;          // Vertical height accessible from interior walkthrough lines
partition_spacing  = 300.00;           // Bin divider separation grid width

module otterbox_side_racking_units() {
    echo("COMPILING OTTERBOX DUAL-DENSITY MODULAR WORK VAN BIN AND SHELVING COMPARTMENTS");
    // Left and Right parallel wall storage stacks optimized for industrial cargo retention [INDEX]
    for (side = [-1, 1]) {
        translate([side * (84.00 * inch_to_mm / 2 - rack_depth/2 - 10), 0, rack_height/2]) {
            color("DimGrey") {
                difference() {
                    // Main solid shelving unit exterior frame housing
                    cube([rack_depth, rack_length, rack_height], center=true);
                    
                    // Hollow out shelves (4 horizontal storage tiers)
                    for (z_tier = [-500, -160, 160, 500]) {
                        translate([2, 0, z_tier])
                            cube([rack_depth, rack_length - 32, 240], center=true);
                    }
                }
            }
            
            // Deploy vertical parts dividers inside individual tiers
            color("DarkCharcoal") {
                for (y_div = [-rack_length/2 + partition_spacing : partition_spacing : rack_length/2 - partition_spacing]) {
                    for (z_tier = [-500, -160, 160, 500]) {
                        translate([0, y_div, z_tier])
                            cube([rack_depth - 4, 12.0, 230], center=true);
                    }
                }
            }
        }
    }
}

// --- Compile Industrial Storage Assembly ---
otterbox_side_racking_units();
