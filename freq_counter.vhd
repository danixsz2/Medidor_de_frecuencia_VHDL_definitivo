library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity freq_counter is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
signal_in : in STD_LOGIC;
gate_1s : in STD_LOGIC;
frequency : out STD_LOGIC_VECTOR(15 downto 0)
);
end freq_counter;

architecture Structural of freq_counter is

component Edge_detector
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
signal_in : in STD_LOGIC;
pulse_out : out STD_LOGIC
);
end component;

signal edge_pulse : STD_LOGIC;

signal count_reg : UNSIGNED(15 downto 0) := (others => '0');
signal freq_reg : UNSIGNED(15 downto 0) := (others => '0');

begin

EDGE_DET : Edge_detector
port map (
clk => clk,
rst => rst,
signal_in => signal_in,
pulse_out => edge_pulse
);

process(clk, rst)
begin
if rst = '1' then

count_reg <= (others => '0');
freq_reg <= (others => '0');

elsif rising_edge(clk) then

-- gate_1s es un pulso de 1 ciclo cada segundo.
-- Cuando llega, se guarda la cuenta y se reinicia.
if gate_1s = '1' then

if edge_pulse = '1' then
freq_reg <= count_reg + 1;
else
freq_reg <= count_reg;
end if;

count_reg <= (others => '0');

else

-- Durante todo el segundo, contar flancos normalmente.
if edge_pulse = '1' then
count_reg <= count_reg + 1;
end if;

end if;

end if;
end process;

frequency <= STD_LOGIC_VECTOR(freq_reg);

end Structural;