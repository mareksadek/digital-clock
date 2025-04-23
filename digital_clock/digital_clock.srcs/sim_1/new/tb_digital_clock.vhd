----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2025 12:24:49
-- Design Name: 
-- Module Name: tb_digital_clock - Behavioral
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
-- Generation date : Wed, 16 Apr 2025 10:18:44 GMT
-- Request id : cfwk-fed377c2-67ff84045c40b

library ieee;
use ieee.std_logic_1164.all;

entity tb_digital_clock is
end tb_digital_clock;

architecture tb of tb_digital_clock is

    component digital_clock
        port (clk               : in std_logic;
              rst               : in std_logic;
              set_hours_plus    : in std_logic_vector (1 downto 0);
              set_hours_minus   : in std_logic_vector (1 downto 0);
              set_minutes_plus  : in std_logic_vector (1 downto 0);
              set_minutes_minus : in std_logic_vector (1 downto 0);
              hours             : out std_logic_vector (5 downto 0);
              minutes           : out std_logic_vector (5 downto 0);
              seconds           : out std_logic_vector (5 downto 0));
    end component;

    signal clk               : std_logic;
    signal rst               : std_logic;
    signal set_hours_plus    : std_logic_vector (1 downto 0);
    signal set_hours_minus   : std_logic_vector (1 downto 0);
    signal set_minutes_plus  : std_logic_vector (1 downto 0);
    signal set_minutes_minus : std_logic_vector (1 downto 0);
    signal hours             : std_logic_vector (5 downto 0);
    signal minutes           : std_logic_vector (5 downto 0);
    signal seconds           : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : digital_clock
    port map (clk               => clk,
              rst               => rst,
              set_hours_plus    => set_hours_plus,
              set_hours_minus   => set_hours_minus,
              set_minutes_plus  => set_minutes_plus,
              set_minutes_minus => set_minutes_minus,
              hours             => hours,
              minutes           => minutes,
              seconds           => seconds);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- Clock main signal
    clk <= TbClock;

stimuli : process
begin
    -- Initialization
    set_hours_plus    <= (others => '0');
    set_hours_minus   <= (others => '0');
    set_minutes_plus  <= (others => '0');
    set_minutes_minus <= (others => '0');
    rst               <= '0';

    -- Reset pulse
    rst <= '1';
    wait for 200 ns;
    rst <= '0';
    wait for 500 ns;

    -- Let the clock run for about 1 second
    wait for 1 us;

    -- Set hours +1 (set_hours_plus = "01")
    set_hours_plus <= "01";
    wait for TbPeriod;
    set_hours_plus <= "00";
    wait for 500 ns;

    -- Set minutes +1 (set_minutes_plus = "01")
    set_minutes_plus <= "01";
    wait for TbPeriod;
    set_minutes_plus <= "00";
    wait for 500 ns;

    -- Set hours -1 (set_hours_minus = "01")
    set_hours_minus <= "01";
    wait for TbPeriod;
    set_hours_minus <= "00";
    wait for 500 ns;

    -- Set minutes -1 (set_minutes_minus = "01")
    set_minutes_minus <= "01";
    wait for TbPeriod;
    set_minutes_minus <= "00";
    wait for 500 ns;

    -- Let the clock run for about 2 more seconds
    wait for 2 us;

    -- End simulation
    TbSimEnded <= '1';
    wait;
end process;

end tb;
-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_digital_clock of tb_digital_clock is
    for tb
    end for;
end cfg_tb_digital_clock;
