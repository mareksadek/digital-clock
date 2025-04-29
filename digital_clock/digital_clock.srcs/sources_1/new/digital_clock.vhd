library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity digital_clock is
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        hours : out std_logic_vector(5 downto 0);
        minutes : out std_logic_vector(5 downto 0);
        seconds : out std_logic_vector(5 downto 0);
        led     : out std_logic  
        
    );
    
end digital_clock;

architecture Behavioral of digital_clock is
    signal sec_count   : std_logic_vector(5 downto 0) := "000000"; -- seconds
    signal min_count   : std_logic_vector(5 downto 0) := "000000"; -- minutes
    signal hr_count    : std_logic_vector(5 downto 0) := "000000"; -- hours
    signal alarm_enabled : STD_LOGIC := '0';
    signal alarm_triggered : STD_LOGIC := '0';
    signal counter       : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    signal blink         : STD_LOGIC := '0';

begin
process(clk, rst)
begin
    if rst = '1' then
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
      end if;  
end process;

    -- Detection of alarm
    process(alarm_enabled)
    begin
        if alarm_enabled = '1' then
            alarm_triggered <= '1';
        else
            alarm_triggered <= '0';
        end if;
    end process;

    -- LED blicking
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = X"5F5E10" then -- circa 5 seconds in 100 MHz
                counter <= (others => '0');
                blink <= not blink;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Output to led
    led <= blink;

    -- Outputs
    hours <= hr_count;
    minutes <= min_count;
    seconds <= sec_count;

end Behavioral;
