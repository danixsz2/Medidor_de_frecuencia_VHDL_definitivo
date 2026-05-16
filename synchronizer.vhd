library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synchronizer is
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
async_in : in STD_LOGIC;
sync_out : out STD_LOGIC
);
end synchronizer;

architecture Behavioral of synchronizer is

signal ff1 : STD_LOGIC := '0';
signal ff2 : STD_LOGIC := '0';

begin

process(clk, rst)
begin
if rst = '1' then
ff1 <= '0';
ff2 <= '0';

elsif rising_edge(clk) then
ff1 <= async_in;
ff2 <= ff1;
end if;
end process;

sync_out <= ff2;

end Behavioral;