----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2022 12:37:14 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library UNISIM; use UNISIM.VComponents.all;

package p_Top is
    type darray is array (0 to 31, 1 to 19) of STD_LOGIC_VECTOR(7 downto 0);
    type ROMtype is array (0 to 399) of STD_LOGIC_VECTOR(2 downto 0);
end package p_Top;

use work.p_Top.all;

library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library UNISIM; use UNISIM.VComponents.all;

entity top is
    Port( 
        clk :   in std_logic;
        reset:  in std_logic;
        button1: in std_logic;
        button2: in std_logic;
        colours: out std_logic_vector(2 downto 0) := (others => '0');
        h_sync: out std_logic;
        v_sync: out std_logic
    );
end Top;

architecture Behavioral of top is


component VGA is
     Port ( 	clk25 :              in STD_LOGIC;
            reset :              in STD_LOGIC;
            ColoursIn:           in STD_LOGIC_VECTOR(2 downto 0);
			red, green, blue :   out  STD_LOGIC;
			hsync, vsync :       out  STD_LOGIC;
			enable:              out std_logic;
			sprLoc:              out integer;
			hspr:                in std_logic_vector(9 downto 0) := (others => '0');
            vspr:                in std_logic_vector(9 downto 0) := (others => '0')
        );
end component;

component sprites is
    Port( 
        reset:      in std_logic;
        clk25:      in std_logic;
        enable:     in std_logic;
        b1:         in std_logic;
        b2:         in std_logic;
        location:   in integer;
        hsprite:    out std_logic_vector(9 downto 0) := "0010010000";
        vsprite:    out std_logic_vector(9 downto 0) := "0000011111";
        ColoursOut: out std_logic_vector(2 downto 0)
    );
end component;

component Prescaler25 is
  Port ( 
    clk_25 : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end component;

signal tmp_colour : std_logic_vector(2 downto 0);
signal tmp_loc : integer;
signal tmp_clk25 : std_logic;
signal tmp_en : std_logic;

signal tmp_h: std_logic_vector(9 downto 0) := (others => '0');
signal tmp_v: std_logic_vector(9 downto 0) := (others => '0');
begin

Pre0: Prescaler25 port map (
    clk_25 => tmp_clk25,
    reset => reset,
    clk_in1 => clk
);

SP0: sprites port map (
    clk25 => tmp_clk25,
    reset => reset,
    enable => tmp_en,
    b1 => button1,
    b2 => button2,
    Location => tmp_loc,
    hsprite => tmp_h,
    vsprite => tmp_v,
    ColoursOut => tmp_colour
);

VGA0: VGA port map(
    clk25 => tmp_clk25,
    reset => reset,
    ColoursIn => tmp_colour,
    red => colours(2),
    blue => colours(1),
    green => colours(0),
    hsync => h_sync,
    vsync => v_sync,
    enable => tmp_en,
    sprLoc => tmp_loc,
    hspr => tmp_h,
    vspr => tmp_v
);

end Behavioral;
