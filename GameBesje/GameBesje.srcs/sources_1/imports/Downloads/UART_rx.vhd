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


entity UART_rx is

    generic(
        BAUD_X16_CLK_TICKS: integer := 54); -- (clk / baud_rate) / 16 => (100 000 000 / 115 200) / 16 = 54.25

    port(
        clk            : in  std_logic;
        reset          : in  std_logic;
        enVGA          : in  std_logic;        
        arrayOut      :   out darray;
        avSig         : out std_logic;
        rx_data_in     : in  std_logic;
        rx_audio_out    : out std_logic_vector (6 downto 0); --6
        rx_video_out    : out std_logic_vector (6 downto 0)  --6
        );
end UART_rx;


architecture Behavioral of UART_rx is

    type rx_states_t is (IDLE, START, DATA, STOP);
    signal rx_state: rx_states_t := IDLE;
    signal baud_rate_x16_clk  : std_logic := '0';
    signal rx_stored_data     : std_logic_vector(7 downto 0);
    signal videoData          : std_logic_vector(6 downto 0);
    signal gridDone           : std_logic; 
    --Sprites

begin

   
    
    


-- The baud_rate_x16_clk_generator process generates an oversampled clock.
-- The baud_rate_x16_clk signal is 16 times faster than the baud rate clock.
-- Oversampling is needed to put the capture point at the middle of duration of
-- the receiving bit.
-- The BAUD_X16_CLK_TICKS constant reflects the ratio between the master clk
-- and the x16 baud rate.

    baud_rate_x16_clk_generator: process(clk)
    variable baud_x16_count: integer range 0 to (BAUD_X16_CLK_TICKS - 1) := (BAUD_X16_CLK_TICKS - 1);
       
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                baud_rate_x16_clk <= '0';
                baud_x16_count := (BAUD_X16_CLK_TICKS - 1);
            else
                if (baud_x16_count = 0) then
                    baud_rate_x16_clk <= '1';
                    baud_x16_count := (BAUD_X16_CLK_TICKS - 1);
                else
                    baud_rate_x16_clk <= '0';
                    baud_x16_count := baud_x16_count - 1;
                end if;
            end if;
        end if;
    end process baud_rate_x16_clk_generator;


-- The UART_rx_FSM process represents a Finite State Machine which has
-- four states (IDLE, START, DATA, STOP). See inline comments for more details.

    UART_rx_FSM: process(clk)
        variable bit_duration_count : integer range 0 to 15 := 0;
        variable bit_count          : integer range 0 to 7  := 0;
     --Sprites
    variable conf_array: darray := (others => (others => 0));
    variable x: integer := 0;
    variable y: integer := 0;
    
    variable s : integer := 0;

    variable enElement : integer := 0;
    variable cntElements : integer :=0;
    variable cntData : integer :=0;
    --       
        
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                rx_state <= IDLE;
                rx_stored_data <= (others => '0');
                rx_video_out <= (others => '0');
                bit_duration_count := 0;
                bit_count := 0;
            else
                if (baud_rate_x16_clk = '1') then     -- the FSM works 16 times faster the baud rate frequency
                    case rx_state is

                        when IDLE =>

                            rx_stored_data <= (others => '0');    -- clean the received data register
                            bit_duration_count := 0;              -- reset counters
                            bit_count := 0;
                            
                            if (rx_data_in = '0') then             -- if the start bit received
                                rx_state <= START;                 -- transit to the START state
                            end if;

                        when START =>

                            if (rx_data_in = '0') then             -- verify that the start bit is preset
                                if (bit_duration_count = 7) then   -- wait a half of the baud rate cycle
                                    rx_state <= DATA;              -- (it puts the capture point at the middle of duration of the receiving bit)
                                    bit_duration_count := 0;
                                else
                                    bit_duration_count := bit_duration_count + 1;
                                end if;
                            else
                                rx_state <= IDLE;                  -- the start bit is not preset (false alarm)
                            end if;

                        when DATA =>

                            if (bit_duration_count = 15) then                -- wait for "one" baud rate cycle (not strictly one, about one)
                                rx_stored_data(bit_count) <= rx_data_in;     -- fill in the receiving register one received bit.
                                bit_duration_count := 0;
                                if (bit_count = 7) then                      -- when all 8 bit received, go to the STOP state
                                    rx_state <= STOP;
                                    bit_duration_count := 0;
                                else
                                    bit_count := bit_count + 1;
                                end if;
                            else
                                bit_duration_count := bit_duration_count + 1;
                            end if;

                        when STOP =>

                            if (bit_duration_count = 15) then      -- wait for "one" baud rate cycle
                                videoData(0) <= rx_stored_data(0);     -- transer the received data to the outside world
                                videoData(1) <= rx_stored_data(1);     -- transer the received data to the outside world
                                videoData(2) <= rx_stored_data(2);     -- transer the received data to the outside world
                                videoData(3) <= rx_stored_data(3);     -- transer the received data to the outside world
                                videoData(4) <= rx_stored_data(4);     -- transer the received data to the outside world
                                videoData(5) <= rx_stored_data(5);     -- transer the received data tso the outside world
                                videoData(6) <= rx_stored_data(6);     -- transer the received data to the outside world
                                rx_video_out <= videoData;
                                avSig <= rx_stored_data(7);     -- transer the received data to the outside world
                                rx_state <= IDLE;                                        
                                
                                     
                                --Sprite                                
                                s := to_integer(unsigned(videoData));
                                conf_array(x,y) := s;
                                if (x = 31) then
                                    if (y = 23) then
                                        y := 0;
                                        -- done
                                        gridDone <= '1';
                                    else
                                        y := y + 1;
                                    end if;
                                    x := 0;
                                else
                                    x := x + 1;             
                                end if;
                                --
                                if enVGA = '1'  then
                                    arrayOut <= conf_array;
                                    gridDone <= '0';
                                end if;                                
                                rx_state <= IDLE;
                            else
                                bit_duration_count := bit_duration_count + 1;
                            end if;

                        when others =>
                            rx_state <= IDLE;
                    end case;
                end if;
            end if;
        end if;
        --VGA
       -- if enVGA'event and enVGA = '1' then
         --   arrayOut <= conf_array;
        --end if;
        --       
    end process UART_rx_FSM;
    
end Behavioral;