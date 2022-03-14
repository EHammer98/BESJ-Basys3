library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library UNISIM; use UNISIM.VComponents.all;

package p_Top is
    type darray is array (0 to 31, 0 to 23) of integer;
    type ROMtype is array (0 to 399) of STD_LOGIC_VECTOR(2 downto 0);
end package p_Top;

use work.p_Top.all;

library IEEE; use IEEE.STD_LOGIC_1164.ALL; use IEEE.NUMERIC_STD.ALL;
library UNISIM; use UNISIM.VComponents.all;

entity top is
    Port( 
        clk :   in std_logic;
        reset:  in std_logic;
        rx:  in std_logic;
        button1: in std_logic;
        button2: in std_logic;
        colours: out std_logic_vector(2 downto 0) := (others => '0');
        h_sync: out std_logic;
        v_sync: out std_logic;
        data_out         : out std_logic_vector (7 downto 0)
    );
end Top;

architecture Behavioral of top is


component VGA is
    Port ( 	
        clk25 :              in STD_LOGIC;
        reset :              in STD_LOGIC;
        arrayIn :            in darray;
        red, green, blue :   out STD_LOGIC;
        hsync, vsync :       out STD_LOGIC;
        enable:              out std_logic
    );
end component;

component sprites is
    Port( 
        reset:      in std_logic;
        clk25:      in std_logic;
        enable:     in std_logic;
        b1:         in std_logic;
        b2:         in std_logic;
        dataIn:     in std_logic_vector(7 downto 0);
        arrayOut:   out darray
    );
end component;

component UART_rx
    port(
        clk            : in  std_logic;
        reset          : in  std_logic;
        rx_data_in     : in  std_logic;
        rx_data_out    : out std_logic_vector (7 downto 0)
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
signal tmp_code : integer;
signal tmp_array : darray;
signal dataIN : std_logic_vector(7 downto 0);

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
    arrayOut => tmp_array,
    dataIn => dataIN
);

receiver: UART_rx
port map(
        clk            => clk,
        reset          => reset,
        rx_data_in     => rx,
        rx_data_out    => dataIN
        );

VGA0: VGA port map(
    clk25 => tmp_clk25,
    reset => reset,
    arrayIn => tmp_array,
    red => colours(2),
    green => colours(1),
    blue => colours(0),
    hsync => h_sync,
    vsync => v_sync
);
data_out <= dataIN;
end Behavioral;
