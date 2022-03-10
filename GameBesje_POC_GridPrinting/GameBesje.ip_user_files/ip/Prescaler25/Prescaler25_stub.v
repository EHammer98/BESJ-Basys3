// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Mar  6 14:37:53 2022
// Host        : Barfie running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/PROGHProjecten/PROGH2/Project_Besje/GameBesje/GameBesje.srcs/sources_1/ip/Prescaler25/Prescaler25_stub.v
// Design      : Prescaler25
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module Prescaler25(clk_25, reset, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_25,reset,clk_in1" */;
  output clk_25;
  input reset;
  input clk_in1;
endmodule