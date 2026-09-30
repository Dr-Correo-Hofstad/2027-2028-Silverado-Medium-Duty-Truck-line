#!/usr/bin/env python3
# ==============================================================================
# REVOLUTIONARY TECHNOLOGY COMPANY & UNIVERSITY OF WASHINGTON DEPARTMENT OF PHYSICS
# Module: src/core/van_env_governor.py (Van Environmental & Shelving Monitor)
# Core Framework: 16-State Hexadecimal Close-Loop Vapor & Cargo Balancer
# ==============================================================================

class RTVanEnvironmentGovernor:
    def __init__(self):
        # Native 16 discrete voltage intervals mapping sensor charge tracking [INDEX]
        self.HEX_VOLTAGE_STAGES = [0.0, 0.0625, 0.125, 0.1875, 0.25, 0.3125, 0.375, 0.4375,
                                   0.5, 0.5625, 0.625, 0.6875, 0.75, 0.8125, 0.875, 1.0]
        self.CRITICAL_VAPOR_INDEX = 12 # 75% humidity threshold parameter before fan actuate [INDEX]

    def convert_analog_to_hex(self, line_volts: float) -> int:
        """
        Bypasses binary communication delays by converting analog sensor tracks [INDEX]
        directly to the closest 16-state hexadecimal index value.
        """
        clamped_input = max(0.0, min(1.0, line_volts))
        closest_index = min(range(len(self.HEX_VOLTAGE_STAGES)),
                            key=lambda i: abs(self.HEX_VOLTAGE_STAGES[i] - clamped_input))
        return closest_index

    def audit_van_cargo_bay(self, scupper_v: float, bins_locked_flag: bool) -> dict:
        """
        Coordinates environmental weatherproofing and cargo load safety variables [INDEX]
        across the 108-bit register matrix to safely maintain fleet vehicle uptime.
        """
        vapor_hex_idx = self.convert_analog_to_hex(scupper_v)
        
        force_active_ventilation = False
        propulsion_authorized    = True
        van_status_log_string    = "VAN_CARGO_BAY_SECURE_AND_DRY"
        univac_status_code       = 0x000
        
        # Core environmental and safety logic verification rules
        if vapor_hex_idx >= self.CRITICAL_VAPOR_INDEX:
            # High condensation detected behind panels: fire active blowers to flush moisture [INDEX]
            force_active_ventilation = True
            van_status_log_string    = "MOISTURE GRADIENT DETECTED: ENFORCING ACTIVE VENTILATION PURGE"
            univac_status_code       = 0x1E4 # Specific fan status display indicator code [INDEX]
            
        if not bins_locked_flag:
            # An OtterBox shelving bin latch has slipped open during transit [INDEX]
            propulsion_authorized    = False
            van_status_log_string    = "TACTICAL ALERT: UNLOCKED OTTERBOX CARGO MATERIAL DETECTED! TORQUE PRE-SET TO CLAMP"
            univac_status_code       = 0x7E3 # Emergency safety fault code register bit flag [INDEX]
            
        # Pack statistics inside the un-truncated 108-bit tracking system register configuration [INDEX]
        # Bits 72-107: Blower State | Bits 36-71: Torque Cap | Bits 0-35: Alert Index
        blower_bit = 1 if force_active_ventilation else 0
        torque_cap = 400 if not propulsion_authorized else 3200 # Limits max motor torque if cargo slips [INDEX]
        stacked_word = (blower_bit << 72) | (torque_cap << 36) | univac_status_code
        
        return {
            "ACTUATE_EXHAUST_BLOWERS": force_active_ventilation,
            "PROPULSION_TORQUE_LIMIT_NM": torque_cap,
            "UNIVAC_COCKPIT_DISPLAY_LOG": van_status_log_string,
            "UNIVAC_IX_36BIT_WORD": f"0x{(stacked_word >> 72) & 0x7FFFFFFFF:09X}"
        }

if __name__ == "__main__":
    governor = RTVanEnvironmentGovernor()
    print("=======================================================================")
    print("UNIVAC-IX WORK VAN CARGO MONITOR ACTIVE (VAN-ENV-GATE-IX)")
    print("=======================================================================")
    
    # Simulation: Van pulls through a deep rainwater puddle, triggering a scupper moisture pulse
    mock_scupper_v  = 0.7500 # Vapor hits threshold limits inside the panel paths [INDEX]
    mock_bins_secure = True
    
    run_log = governor.audit_van_cargo_bay(mock_scupper_v, mock_bins_secure)
    print(f"[DATA SENSE] Scupper Vapor Index: {governor.convert_analog_to_hex(mock_scupper_v)} | Storage Bins Locked: {mock_bins_secure}")
    print(f"[CARGO HOUSING STATUS]: {run_log['UNIVAC_COCKPIT_DISPLAY_LOG']}")
    print(f"[ENVIRONMENT ENGINE]: Engage Active Purification Blowers: {run_log['ACTUATE_EXHAUST_BLOWERS']}")
    print(f"[PROPULSION INTERLOCK]: Restricting Stator Current Torque Max To: {run_log['PROPULSION_TORQUE_LIMIT_NM']} Nm")
    print(f"[MAINFRAME PACKET STREAM]: Serializing Word: {run_log['UNIVAC_IX_36BIT_WORD']}")
    print("=======================================================================")
