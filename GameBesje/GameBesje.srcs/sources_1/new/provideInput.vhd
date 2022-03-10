----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2022 01:21:07 PM
-- Design Name: 
-- Module Name: provideInput - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

package p_provideInput is

    type darray is array (0 to 31, 1 to 19) of STD_LOGIC_VECTOR(7 downto 0);
    
end package p_provideInput;

use work.p_provideInput.all;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;


entity provideInput is
Port(
    clk: IN STD_LOGIC;
    b1: IN STD_LOGIC;
    b2: IN STD_LOGIC;
    en: IN STD_LOGIC;
    output: out darray
);
end provideInput;


architecture Behavioral of provideInput is

signal test : darray := (others => (others => X"00"));
signal check: integer := 0; 
signal oldCheck: integer := 0; 
signal control: integer := 0; 

begin

process(clk)
begin
    if rising_edge(clk) then
        if b1 = '1' and b2 = '0' then
            if check > 0 and control = 0 then
                oldCheck <= check;
                check <= check - 1;
                control <= 1;
            end if;
        elsif b1 = '0' and b2 = '1' then
            if check < 31 and control = 0 then
                oldCheck <= check;
                check <= check + 1;
                control <= 1;
            end if;
        end if;
    end if;
    
    if en = '1' then
        test(oldCheck, 10) <= X"00";
        test(Check, 10) <= X"01";
        control <= 0;
    end if;
end process;

test(0,1) <= X"10";

output <= test;
end Behavioral;
