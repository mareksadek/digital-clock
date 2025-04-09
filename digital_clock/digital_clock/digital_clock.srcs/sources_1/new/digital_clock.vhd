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
    signal sec_count   : std_logic_vector(5 downto 0) := "000000"; -- sekundy
    signal min_count   : std_logic_vector(5 downto 0) := "000000"; -- minuty
    signal hr_count    : std_logic_vector(5 downto 0) := "000000"; -- hodiny

begin
    process(clk, rst)
    begin
        if rst = '1' then
            sec_count <= "000000";
            min_count <= "000000";
            hr_count  <= "000000";
        elsif clk = '1' and clk'event then  -- Zmena na hodinovem signalu
            -- Inkrementace sekund
            if sec_count = "111011" then  -- 59 sekund
                sec_count <= "000000";
                -- Inkrementace minut
                if min_count = "111011" then  -- 59 minut
                    min_count <= "000000";
                    -- Inkrementace hodin
                    if (hr_count = "10111") then 
                        hr_count <= "000000"; -- Reset na 0
                    else
                        hr_count <= hr_count + 1;
                    end if;
                else
                    min_count <= min_count + 1;
                end if;
            else
                sec_count <= sec_count + 1;
            end if;
        end if;
    end process;

    -- Nastaveni hodin tlacitkem
    process(set_hours)
    begin
        if set_hours(0) = '1' and set_hours'event then
            if (hr_count = "1011") then  
                hr_count <= "000001";  -- Reset na 1
            elsif (hr_count = "10111") then  
                hr_count <= "000000";  -- Reset na 0
            else
                hr_count <= hr_count + 1;
            end if;
        end if;
    end process;

    -- Nastaveni minut tlacitkem
    process(set_minutes)
    begin
        if set_minutes(0) = '1' and set_minutes'event then
            if min_count = "111011" then  -- 59 minut
                min_count <= "000000";
            else
                min_count <= min_count + 1;
            end if;
        end if;
    end process;

    -- Vystupy
    hours <= hr_count;
    minutes <= min_count;
    seconds <= sec_count;
end Behavioral;
