library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
button_in : in STD_LOGIC;
button_out : out STD_LOGIC
);
end debounce;

architecture Behavioral of debounce is

-- Basys 3: clk = 100 MHz
-- 10 ms = 1 000 000 ciclos
constant DEBOUNCE_COUNT : UNSIGNED(19 downto 0)
:= to_unsigned(999999, 20);

signal btn_ff1 : STD_LOGIC := '0';
signal btn_ff2 : STD_LOGIC := '0';

signal stable_btn : STD_LOGIC := '0';
signal candidate : STD_LOGIC := '0';
signal counter : UNSIGNED(19 downto 0) := (others => '0');

begin

process(clk, rst)
begin
if rst = '1' then

btn_ff1 <= '0';
btn_ff2 <= '0';

stable_btn <= '0';
candidate <= '0';
counter <= (others => '0');

elsif rising_edge(clk) then

-- Sincronización del botón
btn_ff1 <= button_in;
btn_ff2 <= btn_ff1;

-- Debounce
if btn_ff2 /= candidate then

candidate <= btn_ff2;
counter <= (others => '0');

else

if counter < DEBOUNCE_COUNT then
counter <= counter + 1;
else
stable_btn <= candidate;
end if;

end if;

end if;
end process;

button_out <= stable_btn;

end Behavioral;