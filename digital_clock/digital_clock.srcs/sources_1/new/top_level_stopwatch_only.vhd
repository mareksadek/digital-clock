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

-------------------------------------------------

entity top_level is
  port (
    CLK100MHZ : in    std_logic;                     --! Main clock
    CA        : out   std_logic;                     --! Cathode of segment A
    CB        : out   std_logic;                     --! Cathode of segment B
    CC        : out   std_logic;                     --! Cathode of segment C
    CD        : out   std_logic;                     --! Cathode of segment D
    CE        : out   std_logic;                     --! Cathode of segment E
    CF        : out   std_logic;                     --! Cathode of segment F
    CG        : out   std_logic;                     --! Cathode of segment G
    DP        : out   std_logic;                     --! Decimal point
    AN        : out   std_logic_vector(7 downto 0);  --! Common anodes of all on-board displays
    BTNC      : in    std_logic;                     --! Synchronous reset
    BTNU      : in    std_logic;                     --! Set hours +1
    BTND      : in    std_logic;                     --! Set hours -1
    BTNL      : in    std_logic;                     --! Set minutes +1
    BTNR      : in    std_logic;                      --! Set minutes -1
    SW0       : in    std_logic  
 
    
  );
end entity top_level;

-------------------------------------------------

architecture behavioral of top_level is
  -- Component declaration for digital clock

  -- Component declaration for bin2seg
  component bin2seg is
    port (
      clear : in    std_logic;
      bin   : in    std_logic_vector(3 downto 0);
      seg   : out   std_logic_vector(6 downto 0)
    );
  end component bin2seg;
  
  component stopwatch3 is
    port (
   
      start : in    std_logic;
      stp : in    std_logic;
      rst : in    std_logic;
      clk : in std_logic
   
    );
  end component stopwatch3;

  -- Local signals for first counter: 4-bit @ 250 ms
  signal sig_en_250ms   : std_logic;                    --! Clock enable signal for 4-bit counter
  signal sig_count_4bit : std_logic_vector(3 downto 0); --! 4-bit counter value

  -- Local signal for second counter: 16-bit @ 2 ms
  signal sig_en_2ms : std_logic; --! Clock enable signal for 16-bit counter

begin

CLKK : component stopwatch3
    port map (
        clk   => CLK100MHZ,
        start => BTNL,
        stp => BTNC,
        rst => BTNR
    );
AN <= "00000000";  -- Enable only the first display (assuming active low)
DP <= '1';         -- Turn off the decimal point (active low)

  -- Component instantiation of bin2seg
  display : component bin2seg
    port map (
      clear  => BTND,
      bin    => sig_count_4bit,
      seg(6) => CA,
      seg(5) => CB,
      seg(4) => CC,
      seg(3) => CD,
      seg(2) => CE,
      seg(1) => CF,
      seg(0) => CG
    );



end architecture behavioral;
