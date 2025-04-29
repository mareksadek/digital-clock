library ieee;
use ieee.std_logic_1164.all;

entity tb_digital_clock is
end tb_digital_clock;

architecture tb of tb_digital_clock is

    component digital_clock
        port (clk     : in std_logic;
              rst     : in std_logic;
              hours   : out std_logic_vector (5 downto 0);
              minutes : out std_logic_vector (5 downto 0);
              seconds : out std_logic_vector (5 downto 0));
    end component;

    signal clk     : std_logic;
    signal rst     : std_logic;
    signal hours   : std_logic_vector (5 downto 0);
    signal minutes : std_logic_vector (5 downto 0);
    signal seconds : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 1 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : digital_clock
    port map (clk     => clk,
              rst     => rst,
              hours   => hours,
              minutes => minutes,
              seconds => seconds);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';


    clk <= TbClock;

    stimuli : process
    begin
    -- Reset the clock
    rst <= '1';  -- rst activate
    wait for 100 ns;  -- waiting 100 ns 
    rst <= '0';  -- rst deactivate
    wait for 100 ns;  -- waiting 100 ns 

    wait for 5 * TbPeriod;  -- 10 seconds (10 * period of clock signal)

    
    TbSimEnded <= '1';  -- end simulation
    wait;  
end process;

end tb;

configuration cfg_tb_digital_clock of tb_digital_clock is
    for tb
    end for;
end cfg_tb_digital_clock;