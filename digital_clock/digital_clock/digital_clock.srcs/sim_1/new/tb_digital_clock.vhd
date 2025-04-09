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
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            set_hours   : in std_logic_vector(1 downto 0);
            set_minutes : in std_logic_vector(1 downto 0);
            hours       : out std_logic_vector(5 downto 0);
            minutes     : out std_logic_vector(5 downto 0);
            seconds     : out std_logic_vector(5 downto 0);
            display     : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Signaly pro pripojeni
    signal clk         : std_logic := '0';
    signal rst         : std_logic;
    signal set_hours   : std_logic_vector(1 downto 0);
    signal set_minutes : std_logic_vector(1 downto 0);
    signal hours       : std_logic_vector(5 downto 0);
    signal minutes     : std_logic_vector(5 downto 0);
    signal seconds     : std_logic_vector(5 downto 0);
    signal display     : std_logic_vector(6 downto 0);

    constant TbPeriod : time := 100 ns;
    signal TbSimEnded : boolean := false;

begin

    -- Instance DUT (device under test)
    dut: digital_clock
        port map (
            clk         => clk,
            rst         => rst,
            set_hours   => set_hours,
            set_minutes => set_minutes,
            hours       => hours,
            minutes     => minutes,
            seconds     => seconds,
            display     => display
        );

    -- Generovani hodinoveho signalu
    clk_process : process
    begin
        while not TbSimEnded loop
            clk <= '0';
            wait for TbPeriod / 2;
            clk <= '1';
            wait for TbPeriod / 2;
        end loop;
        wait;
    end process;

    -- Stimuly
stimuli : process
begin
    -- Reset systemu
    rst <= '1';
    set_hours <= "00";
    set_minutes <= "00";
    wait for 100 ns;
    rst <= '0';

    -- Nech hodiny bezet 2 sekundy
    wait for 2 sec;

    -- Po 2 sekundach by melo byt seconds = 2
    assert seconds = "000010"
        report "Chyba: seconds by mely byt 2 po 2 sekundach." severity error;

    -- Simulace stisku tlacitka pro pridani jedne hodiny
    set_hours <= "01";
    wait for TbPeriod;
    set_hours <= "00";

    -- Pockej chvili, aby se vystupy stihly zmenit
    wait for 100 ns;

    -- Ocekavame hodiny = 1
    assert hours = "000001"
        report "Chyba: Hodiny nebyly inkrementovany spravne!" severity error;

    -- Simulace stisku tlacitka pro pridani jedne minuty
    set_minutes <= "01";
    wait for TbPeriod;
    set_minutes <= "00";

    wait for 100 ns;

    -- Ocekavame minuty = 1
    assert minutes = "000001"
        report "Chyba: Minuty nebyly inkrementovany spravne!" severity error;

    -- Nech hodiny bezet dalsi 2 sekundy
    wait for 2 sec;

    -- Celkem by melo byt 4 sekundy od resetu
    assert seconds = "000100"
        report "Chyba: Ocekavano 4 sekundy." severity error;

    -- Ukonceni simulace
    TbSimEnded <= true;
    wait;
end process;
end tb;
