library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity top_level is
  port (
    CLK100MHZ : in  std_logic;
    LED16_B   : out std_logic;
    CA, CB, CC, CD, CE, CF, CG : out std_logic;
    DP        : out std_logic;
    AN        : out std_logic_vector(7 downto 0);
    BTNC      : in  std_logic
  );
end entity;

architecture behavioral of top_level is

  -- Component declaration for digital_clock
  component digital_clock is
    port (
      clk         : in std_logic;
      rst         : in std_logic;
      hours       : out std_logic_vector(5 downto 0);
      minutes     : out std_logic_vector(5 downto 0);
      seconds     : out std_logic_vector(5 downto 0);
      led         : out std_logic  
    );
  end component;

  -- Component declaration for bin2seg
  component bin2seg is
    port (
      clear : in  std_logic;
      bin   : in  std_logic_vector(3 downto 0);
      seg : out std_logic_vector(6 downto 0)
    );
  end component;


  -- Local signals
  signal sig_count_4bit : std_logic_vector(3 downto 0);
  signal sig_hours, sig_minutes, sig_seconds : std_logic_vector(5 downto 0);


begin

  -- Instantiation of digital clock
  CLKK : digital_clock
    port map (
      clk         => CLK100MHZ,
      rst         => BTNC,
      hours       => sig_hours,
      minutes     => sig_minutes,
      seconds     => sig_seconds,
      led         => LED16_B  
    );


  -- bin2seg
  display0 : bin2seg
    port map (
      clear => BTNC,
      bin   => sig_count_4bit,
      seg(6) => CA,
      seg(5) => CB,
      seg(4) => CC,
      seg(3) => CD,
      seg(2) => CE,
      seg(1) => CF,
      seg(0) => CG 
    );

  -- Decimal point OFF
  DP <= '1';

  -- Display enable - použijeme jen první display
  AN <= "11111110";

end architecture;

