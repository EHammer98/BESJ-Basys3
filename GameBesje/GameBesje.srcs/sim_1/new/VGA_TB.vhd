----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2022 20:12:11
-- Design Name: 
-- Module Name: VGA_TB - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; use IEEE.STD_LOGIC_ARITH.ALL; use IEEE.STD_LOGIC_UNSIGNED.ALL;

package p_VGA is
    type darray is array (0 to 31, 1 to 19) of STD_LOGIC_VECTOR(7 downto 0); 
end package p_VGA;

use work.p_VGA.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; use IEEE.STD_LOGIC_ARITH.ALL; use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY VGA_TB IS
END VGA_TB;
ARCHITECTURE behavioral OF VGA_TB IS 

component VGA is
    Port ( 	--ColourIn :           in STD_LOGIC_VECTOR(2 downto 0);
            input:               in darray;
			--red, green, blue :   out  STD_LOGIC;
			ROMcounter:          out integer;
			output:              out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

   --SIGNAL ColourIn	:	STD_LOGIC_VECTOR(2 downto 0);
   SIGNAL input	:	darray;
   --SIGNAL red	:	STD_LOGIC;
   --SIGNAL blue	:	STD_LOGIC;
   --SIGNAL green	:	STD_LOGIC;
   SIGNAL ROMcounter	:	integer;
   SIGNAL output	:	STD_LOGIC_VECTOR(7 downto 0);
   
   signal test : darray := (others => (others => X"00"));
    signal OK: boolean := true;

BEGIN

   UUT: VGA PORT MAP(
		--ColourIn => ColourIn,
		input => input,
		--red => red,
		--blue => blue,
		--green => green,
		ROMcounter => ROMcounter,
		output => output
   );
   
   test(1,5) <= X"11";
   test(2,5) <= X"11";
   test(3,5) <= X"11";
   test(4,5) <= X"11";
   test(5,5) <= X"11";
   test(6,5) <= X"11";
   test(7,5) <= X"11";
   test(8,5) <= X"11";
   test(9,5) <= X"11";
   test(10,5) <= X"11";
-- *** Test Bench - User Defined Section ***
   tb : PROCESS
			variable ROMcounter_t	 :	integer;
			variable output_t :	STD_LOGIC_VECTOR(7 downto 0);
			
			
			variable cnt       :  integer;
			variable hex       :  std_logic_vector(7 downto 0);


	BEGIN
		for I in 0 to 640 loop
			input
			
			
			A := To_integer(unsigned(test_case(3 downto 0)));
			B := To_integer(unsigned(test_case(7 downto 4)));
			sum := A+B;
			
			S0_t := to_unsigned(sum,5)(0);
			S1_t := to_unsigned(sum,5)(1);
			S2_t := to_unsigned(sum,5)(2);
			S3_t := to_unsigned(sum,5)(3);
			C_out_t := to_unsigned(sum,5)(4);
			
			wait for 5 ns;
				
			If S0 /= S0_t then
				OK <= false;
			end if;
			
			if S1 /= S1_t then
				OK <= false;
			end if;
			
			if S2 /= S2_t then
				OK <= false;
			end if;
			
			if S3 /= S3_t then
				OK <= false;
			end if;
			
			if C_out /= C_out_t then
				OK <= false;
			end if;
			
			wait for 5 ns;
			
		
		end loop;
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***
END;