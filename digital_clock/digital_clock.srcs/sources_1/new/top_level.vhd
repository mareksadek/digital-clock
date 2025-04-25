library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.all;

entity top_level is
    Port ( 
        CLK100MHZ : in std_logic;  -- 100 MHz hodinový signál
        CA, CB, CC, CD, CE, CF, CG : out std_logic;  -- Segmenty pro 7-segmentový displej
        DP : out std_logic;  -- Dvojtečka
        AN : out std_logic_vector(7 downto 0);  -- Anody pro 4 číslice
        BTNC : in std_logic;  -- Resetovací tlačítko
        BTNU : in std_logic_vector(1 downto 0);  -- Tlačítko pro přidání hodin
        BTND : in std_logic_vector(1 downto 0);  -- Tlačítko pro ubrání hodin
        BTNL : in std_logic_vector(1 downto 0);  -- Tlačítko pro přidání minut
        BTNR : in std_logic_vector(1 downto 0)   -- Tlačítko pro ubrání minut
    );
end entity top_level;

architecture Behavioral of top_level is
    -- Interní signály pro hodiny, minuty a sekundy
    signal sig_hours, sig_minutes, sig_seconds : std_logic_vector(5 downto 0);
    signal digit_0, digit_1, digit_2, digit_3 : std_logic_vector(3 downto 0);
    signal seg_out : std_logic_vector(6 downto 0);
    signal anode   : std_logic_vector(7 downto 0);
    signal digit_sel : std_logic_vector(1 downto 0) := "00";  -- Výběr číslice pro multiplexování
    signal clkdiv : std_logic_vector(15 downto 0) := (others => '0');  -- Čítač pro multiplexování
    signal bin_in : std_logic_vector (3 downto 0);

    -- Instance komponenty pro digitální hodiny
    component digital_clock is
        port (
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
    end component;
    
  component bin2seg is
    port (
        bin   : in std_logic_vector(3 downto 0);  -- 4-bit binary input
        seg   : out std_logic_vector(6 downto 0)  -- 7-segment display output (a to g)
    );
    end component;
    
begin
    -- Instance komponenty pro digitální hodiny
    clock_inst : digital_clock
        port map (
            clk => CLK100MHZ,
            rst => BTNC,
            set_hours_plus => BTNU,
            set_hours_minus => BTND,
            set_minutes_plus => BTNL,
            set_minutes_minus => BTNR,
            hours => sig_hours,
            minutes => sig_minutes,
            seconds => sig_seconds
        );

    -- Rozdělení hodin na jednotlivé číslice
    digit_3 <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_hours)) / 10, 4));  -- Desítky hodin
    digit_2 <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_hours)) mod 10, 4));  -- Jednotky hodin
    digit_1 <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_minutes)) / 10, 4));  -- Desítky minut
    digit_0 <= std_logic_vector(to_unsigned(to_integer(unsigned(sig_minutes)) mod 10, 4));  -- Jednotky minut

    -- Proces pro multiplexování
    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            clkdiv <= clkdiv + 1;
            if clkdiv(15 downto 12) = "0000" then  -- Každé 16 taktů přepínáme číslici
                digit_sel <= std_logic_vector(unsigned(digit_sel) + 1);
            end if;
        end if;
    end process;


    -- Výběr aktuální číslice a dekódování binárního čísla na segmenty
    process(digit_sel, digit_0, digit_1, digit_2, digit_3)
       variable bin_in : std_logic_vector(3 downto 0);
    begin
        case digit_sel is
            when "00" =>
                bin_in := digit_0;
                anode <= "11111110";  -- Aktivace první číslice
            when "01" =>
                bin_in := digit_1;
                anode <= "11111101";  -- Aktivace druhé číslice
            when "10" =>
                bin_in := digit_2;
                anode <= "11111011";  -- Aktivace třetí číslice
            when others =>
                bin_in := digit_3;
                anode <= "11110111";  -- Aktivace čtvrté číslice
        end case;
    end process;
    
        -- Volání komponenty bin2seg pro dekódování číslice na segmenty
        displ : bin2seg
        port map(
            bin => bin_in,  -- Binární číslice pro dekódování
            seg => seg_out   -- Výstup pro segmenty
        );
    -- Přiřazení výstupů pro segmenty
    CA <= seg_out(6);
    CB <= seg_out(5);
    CC <= seg_out(4);
    CD <= seg_out(3);
    CE <= seg_out(2);
    CF <= seg_out(1);
    CG <= seg_out(0);

    -- Dvojtečka mezi hodinami a minutami
    DP <= '0' when digit_sel = "01" else '1';

    -- Přiřazení anody pro aktivní číslici
    AN <= anode;

end architecture;
