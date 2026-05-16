library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seg7_mux is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
refresh_tick : in STD_LOGIC;
value : in STD_LOGIC_VECTOR(15 downto 0);
an : out STD_LOGIC_VECTOR(3 downto 0);
seg : out STD_LOGIC_VECTOR(6 downto 0)
);
end seg7_mux;

architecture Structural of seg7_mux is

component bcd_to_7seg
Port (
bcd : in STD_LOGIC_VECTOR(3 downto 0);
segments : out STD_LOGIC_VECTOR(6 downto 0)
);
end component;

signal digit_sel : UNSIGNED(1 downto 0) := (others => '0');

signal current_bcd : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

signal value_full : INTEGER range 0 to 65535 := 0;
signal value_disp : INTEGER range 0 to 9999 := 0;

signal thousands : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal hundreds : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal tens : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal ones : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

begin

-- Convertir entrada binaria a entero
value_full <= to_integer(unsigned(value));

-- Limitar valor mostrado a 9999 porque la Basys 3 tiene 4 displays
process(value_full)
begin
if value_full > 9999 then
value_disp <= 9999;
else
value_disp <= value_full;
end if;
end process;

-- Separar en dígitos decimales
thousands <= std_logic_vector(to_unsigned((value_disp / 1000) mod 10, 4));
hundreds <= std_logic_vector(to_unsigned((value_disp / 100) mod 10, 4));
tens <= std_logic_vector(to_unsigned((value_disp / 10) mod 10, 4));
ones <= std_logic_vector(to_unsigned(value_disp mod 10, 4));

-- Selector de display
process(clk, rst)
begin
if rst = '1' then

digit_sel <= (others => '0');

elsif rising_edge(clk) then

if refresh_tick = '1' then
digit_sel <= digit_sel + 1;
end if;

end if;
end process;

-- Multiplexado de ánodos
-- an[0] = unidades, display derecho
-- an[1] = decenas
-- an[2] = centenas
-- an[3] = millares, display izquierdo
process(digit_sel, thousands, hundreds, tens, ones)
begin
case digit_sel is

when "00" =>
an <= "1110";
current_bcd <= ones;

when "01" =>
an <= "1101";
current_bcd <= tens;

when "10" =>
an <= "1011";
current_bcd <= hundreds;

when others =>
an <= "0111";
current_bcd <= thousands;

end case;
end process;

BCD_DECODER : bcd_to_7seg
port map (
bcd => current_bcd,
segments => seg
);

end Structural;