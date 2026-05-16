library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_divider is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
gate_1s : out STD_LOGIC;
refresh_tick : out STD_LOGIC
);
end clk_divider;

architecture Behavioral of clk_divider is

-- Basys 3: clk = 100 MHz
-- 100 000 000 ciclos = 1 segundo
constant ONE_SECOND_COUNT : UNSIGNED(26 downto 0)
:= to_unsigned(99_999_999, 27);

-- 100 MHz / 100 000 = 1 kHz
constant REFRESH_COUNT : UNSIGNED(16 downto 0)
:= to_unsigned(99_999, 17);

signal counter_1s : UNSIGNED(26 downto 0) := (others => '0');
signal counter_refresh : UNSIGNED(16 downto 0) := (others => '0');

signal gate_reg : STD_LOGIC := '0';
signal refresh_reg : STD_LOGIC := '0';

begin

-- Pulso de 1 ciclo cada 1 segundo
process(clk, rst)
begin
if rst = '1' then

counter_1s <= (others => '0');
gate_reg <= '0';

elsif rising_edge(clk) then

if counter_1s = ONE_SECOND_COUNT then
counter_1s <= (others => '0');
gate_reg <= '1';
else
counter_1s <= counter_1s + 1;
gate_reg <= '0';
end if;

end if;
end process;

-- Pulso de refresh para multiplexado de display
process(clk, rst)
begin
if rst = '1' then

counter_refresh <= (others => '0');
refresh_reg <= '0';

elsif rising_edge(clk) then

if counter_refresh = REFRESH_COUNT then
counter_refresh <= (others => '0');
refresh_reg <= '1';
else
counter_refresh <= counter_refresh + 1;
refresh_reg <= '0';
end if;

end if;
end process;

gate_1s <= gate_reg;
refresh_tick <= refresh_reg;

end Behavioral;
