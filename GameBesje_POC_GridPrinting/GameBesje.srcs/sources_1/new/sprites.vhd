library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

package p_sprite is
    type darray is array (0 to 31, 0 to 23) of integer; 
end package p_sprite;

use work.p_sprite.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

entity sprites is
    Port( 
        reset:      in std_logic;
        clk25:      in std_logic;
        enable:     in std_logic;
        b1:         in std_logic;
        b2:         in std_logic;
        dataIn:     in std_logic_vector(7 downto 0);
        arrayOut:   out darray
    );
end sprites;

architecture Behavioral of sprites is
    signal test: integer;


begin
    test <= to_integer(unsigned(dataIn));
    process(clk25, reset)
    
    variable conf_array: darray := (others => (others => 0));
    variable x : integer := 0;--
    variable y : integer := 2;--
    variable s : integer := test;
    
    begin
        
        if reset = '1' then
            
            
        elsif rising_edge(clk25) then  
            s := test;
            conf_array(0,2) := s;
            --conf_array(0,2) := 1;
            conf_array(1,2) := 1;
            conf_array(2,2) := 1;
            conf_array(3,2) := 1;
            conf_array(4,2) := 1;
            
            conf_array(16,5) := 2;
            conf_array(17,5) := 2;
            conf_array(18,5) := 2;
            conf_array(19,5) := 2;
            conf_array(20,5) := 2;
            conf_array(21,5) := 2;
            conf_array(22,5) := 2;
            conf_array(23,5) := 2;
            conf_array(24,5) := 2;
            conf_array(25,5) := 2;
            conf_array(26,5) := 2;
            conf_array(27,5) := 2;
            conf_array(28,5) := 2;
            conf_array(29,5) := 2;
            conf_array(30,5) := 2;
            conf_array(31,5) := 2;
            
            conf_array(3,20) := 3;
            
            conf_array(28,20) := 4;
            
            conf_array(17,8) := 5;
            conf_array(2,22) := 6;
            
            conf_array(28,19) := 7;
            conf_array(28,18) := 7;
            conf_array(28,17) := 7;
            conf_array(28,16) := 7;
            
            conf_array(3,19) := 8;
            conf_array(3,18) := 8;
            conf_array(3,17) := 8;
            conf_array(3,16) := 8;
            
            
            conf_array(31,23) := 9;
            conf_array(30,23) := 10;
            
            arrayOut <= conf_array;
        end if;
    end process;
end Behavioral;