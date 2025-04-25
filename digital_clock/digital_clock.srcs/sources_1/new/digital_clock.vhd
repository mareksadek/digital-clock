library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_clock is
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        set_hours_plus : in std_logic_vector(1 downto 0);
        set_hours_minus : in std_logic_vector(1 downto 0);
        set_minutes_plus : in std_logic_vector(1 downto 0);
        set_minutes_minus : in std_logic_vector(1 downto 0);
        hours : out std_logic_vector(5 downto 0);
        minutes : out std_logic_vector(5 downto 0);
        seconds : out std_logic_vector(5 downto 0)
    );
end digital_clock;

architecture Behavioral of digital_clock is
    signal sec_count : std_logic_vector(5 downto 0) := (others => '0');
    signal min_count : std_logic_vector(5 downto 0) := (others => '0');
    signal hr_count  : std_logic_vector(5 downto 0) := (others => '0');
    
    signal counter : unsigned(26 downto 0) := (others => '0');  -- 27-bit counter
    signal one_sec_tick : std_logic := '0';
    
begin

    -- Frequency divider: generates a 1Hz tick from 100MHz
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            one_sec_tick <= '0';
        elsif rising_edge(clk) then
            if counter = 99999999 then  -- 100M - 1
                counter <= (others => '0');
                one_sec_tick <= '1';
            else
                counter <= counter + 1;
                one_sec_tick <= '0';
            end if;
        end if;
    end process;

    process(clk, rst)
    begin
        if rst = '1' then
            sec_count <= (others => '0');
            min_count <= (others => '0');
            hr_count  <= (others => '0');
        elsif rising_edge(clk) then
            -- One second tick
            if one_sec_tick = '1' then
                if sec_count = std_logic_vector(to_unsigned(59, 6)) then
                    sec_count <= (others => '0');
                    if min_count = std_logic_vector(to_unsigned(59, 6)) then
                        min_count <= (others => '0');
                        if hr_count = std_logic_vector(to_unsigned(23, 6)) then
                            hr_count <= (others => '0');
                        else
                            hr_count <= std_logic_vector(unsigned(hr_count) + 1);
                        end if;
                    else
                        min_count <= std_logic_vector(unsigned(min_count) + 1);
                    end if;
                else
                    sec_count <= std_logic_vector(unsigned(sec_count) + 1);
                end if;
            end if;

            -- Set Hours plus
            if set_hours_plus = "01" then
                if hr_count = std_logic_vector(to_unsigned(23, 6)) then
                    hr_count <= (others => '0');
                else
                    hr_count <= std_logic_vector(unsigned(hr_count) + 1);
                end if;
            end if;

            -- Set Hours minus
            if set_hours_minus = "01" then
                if unsigned(hr_count) = 0 then
                    hr_count <= std_logic_vector(to_unsigned(23, 6));
                else
                    hr_count <= std_logic_vector(unsigned(hr_count) - 1);
                end if;
            end if;

            -- Set Minutes plus
            if set_minutes_plus = "01" then
                if min_count = std_logic_vector(to_unsigned(59, 6)) then
                    min_count <= (others => '0');
                else
                    min_count <= std_logic_vector(unsigned(min_count) + 1);
                end if;
            end if;

            -- Set Minutes minus
            if set_minutes_minus = "01" then
                if unsigned(min_count) = 0 then
                    min_count <= std_logic_vector(to_unsigned(59, 6));
                else
                    min_count <= std_logic_vector(unsigned(min_count) - 1);
                end if;
            end if;

        end if;
    end process;

    -- Outputs
    hours   <= hr_count;
    minutes <= min_count;
    seconds <= sec_count;

end Behavioral;
