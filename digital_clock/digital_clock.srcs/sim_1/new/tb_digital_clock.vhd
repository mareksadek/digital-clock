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

    constant TbPeriod : time := 1 ns; -- Put right period here
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

    -- Clock main signal
    clk <= TbClock;

stimuli : process
begin
    -- Inicializace
    set_hours   <= (others => '0');
    set_minutes <= (others => '0');
    rst         <= '0';

    -- Resetovací pulz
    rst <= '1';
    wait for 200 ns;
    rst <= '0';
    wait for 500 ns;

    -- Necháme běžet hodiny cca 1 sekundu (10 kroků po 100 ns)
    wait for 1 us;

    -- Nastavení hodin (set_hours = "01")
    set_hours <= "01";
    wait for TbPeriod;  -- zachytí náběžnou hranu
    set_hours <= "00";
    wait for 500 ns;

    -- Nastavení minut (set_minutes = "01")
    set_minutes <= "01";
    wait for TbPeriod;
    set_minutes <= "00";
    wait for 500 ns;

    -- Druhé nastavení hodin
    set_hours <= "01";
    wait for TbPeriod;
    set_hours <= "00";

    -- Necháme hodiny dále běžet cca 2 sekundy
    wait for 2 us;

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
