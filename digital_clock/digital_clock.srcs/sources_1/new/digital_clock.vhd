library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


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
        hours : out std_logic_vector(5 downto 0);
        minutes : out std_logic_vector(5 downto 0);
        seconds : out std_logic_vector(5 downto 0);
        display: out std_logic_vector(6 downto 0)
    );
    
end digital_clock;

architecture Behavioral of digital_clock is
    signal sec_count   : std_logic_vector(5 downto 0) := "000000"; -- seconds
    signal min_count   : std_logic_vector(5 downto 0) := "000000"; -- minutes
    signal hr_count    : std_logic_vector(5 downto 0) := "000000"; -- hours

begin
process(clk, rst)
begin
    if rst = '1' the
        sec_count <= (others => '0');
        min_count <= (others => '0');
        hr_count  <= (others => '0');
    elsif rising_edge(clk) then
        -- Time update
        if sec_count = std_logic_vector(to_unsigned(59, 6)) then
            sec_count <= (others => '0');
            if min_count = std_logic_vector(to_unsigned(59, 6)) then
                min_count <= (others => '0');
                if hr_count = std_logic_vector(to_unsigned(23, 6)) then
                    hr_count <= (others => '0');
                else
                    hr_count <= hr_count + 1;
                end if;
            else
                min_count <= min_count + 1;
            end if;
        else
            sec_count <= sec_count + 1;
        end if;

        -- Set Hours
        if set_hours = "01" then
            if hr_count = std_logic_vector(to_unsigned(23, 6)) then
                hr_count <= (others => '0');
            else
                hr_count <= hr_count + 1;
            end if;
        end if;

        -- Set Minutes
        if set_minutes = "01" then
            if min_count = std_logic_vector(to_unsigned(59, 6)) then
                min_count <= (others => '0');
            else
                min_count <= min_count + 1;
            end if;
        end if;
    end if;
end process;

    -- Outputs
    hours <= hr_count;
    minutes <= min_count;
    seconds <= sec_count;
end Behavioral;
