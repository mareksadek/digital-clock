library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digital_clock is
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        set_hours : in std_logic_vector(1 downto 0);
        set_minutes : in std_logic_vector(1 downto 0);
        hours : out std_logic;
        minutes : out std_logic;
        seconds : out std_logic;
        display: out std_logic_vector(6 downto 0)
    );
    
end digital_clock;

architecture Behavioral of digital_clock is

begin


end Behavioral;
