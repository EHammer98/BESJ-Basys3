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
        arrayStart:  in std_logic;
        rx:  in std_logic;
        button1: in std_logic;
        button2: in std_logic;
        colours: out std_logic_vector(2 downto 0) := (others => '0');
        h_sync: out std_logic;
        v_sync: out std_logic;
        enLED: out std_logic;
        enArrayLED: out std_logic;
        avLED : out std_logic;
        d : out std_logic_vector(7 downto 0) --6
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
        arStart:     in std_logic;    
        b1:         in std_logic;
        b2:         in std_logic;
        vgaEN:         in std_logic;
        enSig:      in std_logic;
        enArrayOut:      out std_logic;
        dataIn:     in std_logic_vector(6 downto 0);
        arrayOut:   out darray
    );
      
    
end component;

component UART_rx
    port(
        clk            : in  std_logic;
        reset          : in  std_logic;
        enSig         : out std_logic;
        avSig         : out std_logic;
        rx_data_in     : in  std_logic;
        rx_audio_out    : out std_logic_vector (6 downto 0); --6
        rx_video_out    : out std_logic_vector (7 downto 0)  --6
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
signal videoIN : std_logic_vector(7 downto 0); --6
signal audioIN : std_logic_vector(6 downto 0);
signal enSignal : std_logic;
signal avSignal : std_logic;
signal enVGA : std_logic;

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
    arStart => arrayStart,
    b1 => button1,
    b2 => button2,
    enSig => enSignal,
    vgaEN => enVGA,
    enArrayOut => enArrayLED,
    arrayOut => tmp_array,
    dataIn(0) => videoIN(0),   
    dataIn(1) => videoIN(1), 
    dataIn(2) => videoIN(2), 
    dataIn(3) => videoIN(3), 
    dataIn(4) => videoIN(4), 
    dataIn(5) => videoIN(5), 
    dataIn(6) => videoIN(6)
    );


--AU0: audio port map (
--    dataIn => audioIN   
--);

receiver: UART_rx
port map(
        clk            => clk,
        reset          => reset,
        rx_data_in     => rx,
        enSig => enSignal,
        avSig => avSignal,
        rx_video_out    => videoIN,
        rx_audio_out    => audioIN
        );

VGA0: VGA port map(
    clk25 => tmp_clk25,
    reset => reset,
    arrayIn => tmp_array,
    red => colours(2),
    green => colours(1),
    blue => colours(0),
    enable => enVGA,
    hsync => h_sync,
    vsync => v_sync
);
enLED <= arrayStart;
avLED <= avSignal;
d <= videoIN;
end Behavioral;