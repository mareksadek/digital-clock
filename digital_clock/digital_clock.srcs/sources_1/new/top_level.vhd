----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2025 13:08:44
-- Design Name: 
-- Module Name: top_level - Behavioral
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
use ieee.numeric_std.all;

entity top_level is
  port (
    CLK100MHZ : in    std_logic;
    CA        : out   std_logic;
    CB        : out   std_logic;
    CC        : out   std_logic;
    CD        : out   std_logic;
    CE        : out   std_logic;
    CF        : out   std_logic;
    CG        : out   std_logic;
    DP        : out   std_logic;
    AN        : out   std_logic_vector(7 downto 0);
    BTNC      : in    std_logic;
    BTNU      : in    std_logic_vector(1 downto 0);
    BTND      : in    std_logic_vector(1 downto 0);
    BTNL      : in    std_logic_vector(1 downto 0);
    BTNR      : in    std_logic_vector(1 downto 0)
  );
end entity top_level;

architecture behavioral of top_level is

  -- Component declarations
  component digital_clock is
    port (
      clk               : in std_logic;
      rst               : in std_logic;
      set_hours_plus    : in std_logic_vector(1 downto 0);
      set_hours_minus   : in std_logic_vector(1 downto 0);
      set_minutes_plus  : in std_logic_vector(1 downto 0);
      set_minutes_minus : in std_logic_vector(1 downto 0);
      hours             : out std_logic_vector(5 downto 0);
      minutes           : out std_logic_vector(5 downto 0);
      seconds           : out std_logic_vector(5 downto 0)
    );
  end component;

  component bin2seg is
    port (
      clear : in std_logic;
      bin   : in std_logic_vector(3 downto 0);
      seg   : out std_logic_vector(6 downto 0)
    );
  end component;

  -- Internal signals
  signal sig_hours    : std_logic_vector(5 downto 0);
  signal sig_minutes  : std_logic_vector(5 downto 0);
  signal sig_seconds  : std_logic_vector(5 downto 0);
  signal seg_out      : std_logic_vector(6 downto 0);
  signal digit_bin_hours    : std_logic_vector(3 downto 0);
  signal digit_bin_min    : std_logic_vector(3 downto 0);
  signal digit_bin_sec    : std_logic_vector(3 downto 0);  -- For one digit

begin

  -- Instantiate digital clock
  clock_inst : digital_clock
    port map (
      clk               => CLK100MHZ,
      rst               => BTNC,
      set_hours_plus    => BTNU,
      set_hours_minus   => BTND,
      set_minutes_plus  => BTNL,
      set_minutes_minus => BTNR,
      hours             => sig_hours,
      minutes           => sig_minutes,
      seconds           => sig_seconds
    );

  -- Show lower nibble of seconds on 7-seg display
  digit_bin_sec <= sig_seconds(3 downto 0);

      -- Instantiate bin2seg for minutes
  display_inst_seconds : bin2seg
    port map (
      clear => BTNC,
      bin   => digit_bin_sec,
      seg   => seg_out
    );

  -- Assign 7-segment outputs
  CA <= seg_out(6);
  CB <= seg_out(5);
  CC <= seg_out(4);
  CD <= seg_out(3);
  CE <= seg_out(2);
  CF <= seg_out(1);
  CG <= seg_out(0);

  -- Disable decimal point
  DP <= '1';

  -- Enable only one digit (rightmost)
  AN <= "11110000";
  
end architecture behavioral;
