
##########
# Clocks #
##########
create_clock -name CLK -period 10 -waveform {0 5} [get_ports CLK]

###############
# Input Delay #
###############
set_input_delay 0 -clock CLK  -add_delay  [get_ports {RESET DATA_IN* ADRS* LOAD TESTMODE}]

################
# Output Delay #
################
set_output_delay 0 -clock CLK  -add_delay  [get_ports {B_DIGIT_SELECT* DIGIT_SELECT B_SSD_OUT* SSD_OUT*}]

##############################
# Pin Locations and Voltages #
##############################
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports { CLK   }]; 
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports { RESET }];

set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[0] }];
set_property -dict { PACKAGE_PIN V16  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[1] }];
set_property -dict { PACKAGE_PIN W16  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[2] }];
set_property -dict { PACKAGE_PIN W17  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[3] }];
set_property -dict { PACKAGE_PIN W15  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[4] }];
set_property -dict { PACKAGE_PIN V15  IOSTANDARD LVCMOS33 } [get_ports { DATA_IN[5] }];
set_property -dict { PACKAGE_PIN T3   IOSTANDARD LVCMOS33 } [get_ports { ADRS[0] }];
set_property -dict { PACKAGE_PIN T2  IOSTANDARD LVCMOS33 } [get_ports { ADRS[1] }];
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { LOAD }];
 
set_property -dict { PACKAGE_PIN R2  IOSTANDARD LVCMOS33 } [get_ports { TESTMODE  }]; 
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports { B_DIGIT_SELECT[0] }];
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports { B_DIGIT_SELECT[1] }]; 
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports { B_DIGIT_SELECT[2] }]; 
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports { B_DIGIT_SELECT[3] }]; 
set_property -dict { PACKAGE_PIN P18  IOSTANDARD LVCMOS33 } [get_ports { DIGIT_SELECT }];  
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[0]  }]; 
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[1]  }];
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[2]  }];
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[3]  }];
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[4]  }];
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[5]  }];
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports { B_SSD_OUT[6]  }];
set_property -dict { PACKAGE_PIN N17  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[0]  }];
set_property -dict { PACKAGE_PIN M18  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[1]  }];
set_property -dict { PACKAGE_PIN K17  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[2]  }];
set_property -dict { PACKAGE_PIN B16  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[3]  }];
set_property -dict { PACKAGE_PIN B15  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[4]  }];
set_property -dict { PACKAGE_PIN A16  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[5]  }];
set_property -dict { PACKAGE_PIN A14  IOSTANDARD LVCMOS33 } [get_ports { SSD_OUT[6]  }];




##########################
# Configuration Settings #
##########################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

