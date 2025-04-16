----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2025 09:59:51 AM
-- Design Name: 
-- Module Name: stopwatch_tb - Behavioral
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




-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 16 Apr 2025 11:25:00 GMT
-- Request id : cfwk-fed377c2-67ff938c07267

library ieee;
use ieee.std_logic_1164.all;

entity tb_main is
end tb_main;

architecture tb of tb_main is

    component main
        port (start   : in std_logic;
              stop    : in std_logic;
              reset   : in std_logic;
              clock   : in std_logic;
              output  : out std_logic_vector (7 downto 0);
              hours   : out std_logic_vector (5 downto 0);
              minutes : out std_logic_vector (5 downto 0);
              seconds : out std_logic_vector (5 downto 0);
              display : out std_logic_vector (6 downto 0));
    end component;

    signal start   : std_logic;
    signal stop    : std_logic;
    signal reset   : std_logic;
    signal clock   : std_logic;
    signal output  : std_logic_vector (7 downto 0);
    signal hours   : std_logic_vector (5 downto 0);
    signal minutes : std_logic_vector (5 downto 0);
    signal seconds : std_logic_vector (5 downto 0);
    signal display : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : main
    port map (start   => start,
              stop    => stop,
              reset   => reset,
              clock   => clock,
              output  => output,
              hours   => hours,
              minutes => minutes,
              seconds => seconds,
              display => display);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clock is really your main clock signal
    clock <= TbClock;

      stimuli : process
    variable wait_time : time := 100 ms;
begin
    -- Initially reset the system
    reset <= '1';
    wait for 100 ns;  -- Wait for reset to take effect
    reset <= '0';
    wait for 100 ns;

    -- Start the stopwatch
    start <= '1';
    wait for wait_time;  -- Simulate a delay before stopping
    start <= '0';
    wait for 100 ns;

    -- Stop the stopwatch
    stop <= '1';
    wait for 100 ns;
    stop <= '0';
    wait for 100 ns;

    -- Start the stopwatch again
    start <= '1';
    wait for wait_time;
    start <= '0';
    wait for 100 ns;

    -- Stop the stopwatch
    stop <= '1';
    wait for 100 ns;
    stop <= '0';
    wait for 100 ns;

    -- Reset the stopwatch
    reset <= '1';
    wait for 100 ns;
    reset <= '0';

    -- End simulation
    wait for 100 ns;
    TbSimEnded <= '1'; -- End the simulation after a while
    wait;
end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_main of tb_main is
    for tb
    end for;
end cfg_tb_main;
