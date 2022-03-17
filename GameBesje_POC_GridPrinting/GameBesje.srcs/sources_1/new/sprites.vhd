library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;

package p_sprite is
    type darray is array (0 to 31, 0 to 23) of integer; 
    type selector is array (8 downto 0) of integer;
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
        enSig:      in std_logic;
        arrayOut:   out darray
    );
end sprites;

architecture Behavioral of sprites is
    signal data: integer;
    signal dataOld: integer;


begin
    data <= to_integer(unsigned(dataIn));
    process(clk25, reset)
    
    variable conf_array: darray := (others => (others => 0));
    variable x: integer := 0;
    variable y: integer := 0;
    
    variable s : integer := 0;

    variable enElement : integer := 0;
    variable cntElements : integer :=0;
    variable cntData : integer :=0;
   
    begin
        if enSig'event and enSig = '1' then
            s := data;
            conf_array(x,y) := s;
            if (x = 32) then
                if (y = 24) then
                    y := 0;
                    
                else
                    y := y + 1;
                end if;
                x := 0;
            else
                x := x + 1;              
            end if;
                       
      end if;
      
     if rising_edge(clk25) then  
    
    
     arrayOut <= conf_array;
    end if; 
    end process;
end Behavioral;