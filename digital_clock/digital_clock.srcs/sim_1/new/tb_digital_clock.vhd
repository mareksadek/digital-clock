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

library ieee;
use ieee.std_logic_1164.all;

entity tb_digital_clock is
end tb_digital_clock;

architecture tb of tb_digital_clock is

    component digital_clock
        port (clk         : in std_logic;
              rst         : in std_logic;
              set_hours   : in std_logic_vector (1 downto 0);
              set_minutes : in std_logic_vector (1 downto 0);
              hours       : out std_logic_vector (5 downto 0);
              minutes     : out std_logic_vector (5 downto 0);
              seconds     : out std_logic_vector (5 downto 0);
              display     : out std_logic_vector (6 downto 0));
    end component;

    signal clk         : std_logic;
    signal rst         : std_logic;
    signal set_hours   : std_logic_vector (1 downto 0);
    signal set_minutes : std_logic_vector (1 downto 0);
    signal hours       : std_logic_vector (5 downto 0);
    signal minutes     : std_logic_vector (5 downto 0);
    signal seconds     : std_logic_vector (5 downto 0);
    signal display     : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 100 ns; -- 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : digital_clock
    port map (clk         => clk,
              rst         => rst,
              set_hours   => set_hours,
              set_minutes => set_minutes,
              hours       => hours,
              minutes     => minutes,
              seconds     => seconds,
              display     => display);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
    -- Inicializace
    set_hours   <= (others => '0');
    set_minutes <= (others => '0');

    -- Reset
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait for 200 ns;

    -- Simulace běhu hodin na 1 minutu (zrychlená simulace)
    wait for 70 * TbPeriod;

    -- Nastavení hodin tlačítkem
    set_hours(0) <= '1';
    wait for TbPeriod;
    set_hours(0) <= '0';
    wait for 5 * TbPeriod;

    -- Nastavení minut tlačítkem
    set_minutes(0) <= '1';
    wait for TbPeriod;
    set_minutes(0) <= '0';
    wait for 5 * TbPeriod;

    -- Další kliknutí na tlačítka
    set_hours(0) <= '1';
    wait for TbPeriod;
    set_hours(0) <= '0';
    wait for 5 * TbPeriod;

    set_minutes(0) <= '1';
    wait for TbPeriod;
    set_minutes(0) <= '0';

    -- Simulace chodu po změně času
    wait for 50 * TbPeriod;

    -- Ukončení simulace
    TbSimEnded <= '1';
    wait;
end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_digital_clock of tb_digital_clock is
    for tb
    end for;
end cfg_tb_digital_clock;