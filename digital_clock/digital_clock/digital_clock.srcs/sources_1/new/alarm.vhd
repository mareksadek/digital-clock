library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alarm_system is
    Port (
        clk     : in  STD_LOGIC;        -- Hlavní hodinový signál (100 MHz)
        rst     : in  STD_LOGIC;        -- Resetovací tlačítko
        btn     : in  STD_LOGIC;        -- Tlačítko pro zapnutí/vypnutí alarmu
        sw      : in  STD_LOGIC_VECTOR(7 downto 0); -- Spínače jako čidla (SW0 až SW7)
        led     : out STD_LOGIC_VECTOR(0 downto 0)  -- Výstup alarmu (LD0)
    );
end alarm_system;

architecture Behavioral of alarm_system is
    signal alarm_enabled : STD_LOGIC := '0';
    signal btn_prev      : STD_LOGIC := '0';
    signal alarm_triggered : STD_LOGIC := '0';
    signal counter       : STD_LOGIC_VECTOR(25 downto 0) := (others => '0');
    signal blink         : STD_LOGIC := '0';
begin

    -- Proces pro přepnutí alarmu (toggle button)
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                alarm_enabled <= '0';
            elsif btn = '1' and btn_prev = '0' then
                alarm_enabled <= not alarm_enabled;
            end if;
            btn_prev <= btn;
        end if;
    end process;

    -- Proces pro detekci spuštění alarmu
    process(sw, alarm_enabled)
    begin
        if alarm_enabled = '1' and sw /= "00000000" then
            alarm_triggered <= '1';
        else
            alarm_triggered <= '0';
        end if;
    end process;

    -- Blikání LEDky (časovač)
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = X"5F5E10" then -- cca 0.5 sekundy při 100 MHz
                counter <= (others => '0');
                blink <= not blink;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Výstup na LED
    led(0) <= blink when alarm_triggered = '1' else '0';

end Behavioral;
