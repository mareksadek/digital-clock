
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( 
           CLK100MHZ    : in STD_LOGIC;
           BTNC         : in STD_LOGIC;
           BTND         : in STD_LOGIC;
           SW           : in STD_LOGIC_VECTOR (7 downto 0);
           LED16_B      : out STD_LOGIC
           );
end top_level;

architecture Behavioral of top_level is
    component alarm_system
    port (
        clk     : in  STD_LOGIC;                    -- 100 MHz
        rst     : in  STD_LOGIC;                    -- Reset button
        btn     : in  STD_LOGIC;                    -- Button for alarm activation/deactivation
        sw      : in  STD_LOGIC_VECTOR(7 downto 0); -- (SW0 -> SW7)
        led     : out std_logic                     -- Alarm output (LED)
    );
    end component;
begin
    alarm : component alarm_system
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            btn   => BTND,
            sw    => SW,
            led   => LED16_B
        );

end Behavioral;
