----------------------------------------------------------------------------------
-- Company:        Avans 
-- Engineer:       J.vd.Heuvel
-- 
-- Create Date:    14:13:20 04/11/2009 
-- Module Name:    VGA - Behavioral 
-- Target Devices: Xilinx Artix 7
-- Description: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA is
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
end VGA;

architecture Behavioral of VGA is
  signal hcount: STD_LOGIC_VECTOR(9 downto 0);
  signal vcount: STD_LOGIC_VECTOR(9 downto 0);
  signal location: integer := 0;
begin

process (clk25) 
begin
    if reset = '1' then
        hcount <= (others => '0');
        vcount <= (others => '0');
        
        red <= '0';
        green <= '0';
        blue <= '0';
        
        location <= 0;
        
    elsif rising_edge(clk25) then
       if (hcount >= 144) and (hcount < 784) and (vcount >= 31) and (vcount < 511) then
            if (hcount <= hspr + 19) and (hcount >= hspr) and (vcount <= vspr + 19) and (vcount >= vspr) then
                red <= ColoursIn(2);
                green <= ColoursIn(1);
                blue <= ColoursIn(0);
                
                location <= location + 1;
            else
                red <= '0';
                green <= '0';
                blue <= '0';
            end if;  
      else
            red <= '0';
            green <= '0';
            blue <= '0';
      end if;
	 
      if hcount < 97 then
            hsync <= '0';
      else
            hsync <= '1';
      end if;

      if vcount < 3 then
            vsync <= '0';
      else
            vsync <= '1';
      end if;
	 
      hcount <= hcount + 1;
	 
      if hcount = 800 then
            vcount <= vcount + 1;
            hcount <= (others => '0');
      end if;
	 
      if vcount = 521 then		    
            vcount <= (others => '0');
      end if;
      
      if hcount = 799 and vcount = 520 then
        enable <= '1';
        location <= 0;
      else
        enable <= '0';
      end if;
      
    end if;
    
    sprLoc <= location;
end process;

end Behavioral;


