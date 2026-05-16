library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Edge_detector is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
signal_in : in STD_LOGIC;
pulse_out : out STD_LOGIC
);
end Edge_detector;

architecture Behavioral of Edge_detector is

signal signal_prev : STD_LOGIC := '0';

begin

process(clk, rst)
begin
if rst = '1' then
signal_prev <= '0';
pulse_out <= '0';

elsif rising_edge(clk) then

if signal_in = '1' and signal_prev = '0' then
pulse_out <= '1';
else
pulse_out <= '0';
end if;

signal_prev <= signal_in;

end if;
end process;

end Behavioral;