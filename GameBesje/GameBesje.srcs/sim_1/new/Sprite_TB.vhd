----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2022 20:12:11
-- Design Name: 
-- Module Name: Sprite_TB - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

    package p_sprite is
    type darray is array (0 to 31, 1 to 19) of STD_LOGIC_VECTOR(7 downto 0);
    type ROMtype is array (0 to 399) of STD_LOGIC_VECTOR(2 downto 0);
end package p_sprite;

use work.p_sprite.all;

library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library UNISIM; use UNISIM.VComponents.all;


entity Sprite_TB is
end Sprite_TB;

    architecture Behavioral of Sprite_TB is
    
component sprites is
    Port(
        clk25:      in std_logic;
        input:      in std_logic_vector(7 downto 0); --hexcode
        Location:   in integer;
        ColourOut:  out std_logic_vector(2 downto 0) := (others => '0')
        --hsprite:    out std_logic_vector(3 downto 0) := "0000";
        --vsprite:    out std_logic_vector(3 downto 0) := "0000"
    );
end component;

begin


end Behavioral;
