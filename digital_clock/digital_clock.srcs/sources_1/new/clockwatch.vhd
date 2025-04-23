library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity stopwatch is
    Port ( start : in  STD_LOGIC;
           stp : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           hours : out std_logic_vector(5 downto 0);
           minutes : out std_logic_vector(5 downto 0);
           seconds : out std_logic_vector(5 downto 0);
           );
end stopwatch;

architecture Behavioral of stopwatch is
    signal sec_count   : std_logic_vector(5 downto 0) := "000000"; -- seconds
    signal min_count   : std_logic_vector(5 downto 0) := "000000"; -- minutes
    signal hr_count    : std_logic_vector(5 downto 0) := "000000"; -- hours
constant clock_period : time := 1 ms; 
--variable cnt : INTEGER := '0';
type state_type is (idle, running, paused);
signal ps,ns : state_type:=idle;
--deklaruje typy stavov + ps = present state, ns = next state
signal temp : std_logic_vector (7 downto 0) := "00000000";
--begin process (start,stop,reset)
 
begin
SEQ:process(clock)

begin
	if (rising_edge(clock)) then
		ps <= ns;
		--with every rising edge, state is switched to the nexst state (ns)
		case ps is 
			when idle =>
				if (start = '1') then 
					temp <= temp + "00000001";
					output <= temp;
					ns <= running;
				end if; --new value is on output and the clock goes from first state (idle) to the second one (running) 
				if (stp = '1') then 
					output <= temp;
					ns <= ps;
				end if; --(after pressing the button, current output is set and the clock stays at the current state (running)
			when running => 
				if (start = '1') then 
					temp <= temp + "00000001";
					output <= temp;
					ns <= ps;
				end if; --when start button is pressed, clock starts counting and stays in the current state (running)
				if (stp = '1') then 
					output <= temp;
					ns <= paused;
				end if; --when stop button is pressed, output is paused and the state is set to pause
				if (rst = '1') then 
					temp <= "00000000";
					output <= temp;
					ns <= idle;
				end if; --resets the counter and returns counter to the first state (idle)
			when paused =>
				if (start = '1') then 
					temp <= temp + "00000001";
					output <= temp;
					ns <= running;
				end if; --when start button is pressed again, clock starts counting again and the clock returns to the state running
				if (stp = '1') then 
					output <= temp;
					ns <= ps;
				end if; --when stop is pressed again, clock pauses
				if (rst = '1') then 
					temp <= "00000000";
					output <= temp;
					ns <= idle;
				end if; --resets whole clock and return it to the first state (idle)
			when others =>
				null;
		end case;
	end if;
	 if rst = '1' then
            sec_count <= "000000";
            min_count <= "000000";
            hr_count  <= "000000";
        elsif clk = '1' and clk'event then  -- Change to hour signal
            -- Incrementation of seconds
            if sec_count = "111011" then  -- 59 seconds
                sec_count <= "000000";
                -- Incrementation of minutes
                if min_count = "111011" then  -- 59 minutes
                    min_count <= "000000";
                    -- Incrementation of hours
                    if (hr_count = "10111") then 
                        hr_count <= "000000"; -- Reset to 0
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

    hours <= hr_count;
    minutes <= min_count;
    seconds <= sec_count;

end Behavioral;
