-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sun Mar  6 14:37:53 2022
-- Host        : Barfie running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/PROGHProjecten/PROGH2/Project_Besje/GameBesje/GameBesje.srcs/sources_1/ip/Prescaler25/Prescaler25_stub.vhdl
-- Design      : Prescaler25
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Prescaler25 is
  Port ( 
    clk_25 : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end Prescaler25;

architecture stub of Prescaler25 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_25,reset,clk_in1";
begin
end;
