library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_meter_top is
Port (
clk100MHz : in STD_LOGIC;

rst : in STD_LOGIC;

btn_input : in STD_LOGIC;
ext_input : in STD_LOGIC;

sw : in STD_LOGIC;

an : out STD_LOGIC_VECTOR(3 downto 0);
seg : out STD_LOGIC_VECTOR(6 downto 0);

led : out STD_LOGIC_VECTOR(15 downto 0)
);
end freq_meter_top;

architecture Structural of freq_meter_top is

component debounce
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
button_in : in STD_LOGIC;
button_out : out STD_LOGIC
);
end component;

component synchronizer
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
async_in : in STD_LOGIC;
sync_out : out STD_LOGIC
);
end component;

component freq_counter
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
signal_in : in STD_LOGIC;
gate_1s : in STD_LOGIC;
frequency : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component clk_divider
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
gate_1s : out STD_LOGIC;
refresh_tick : out STD_LOGIC
);
end component;

component seg7_mux
Port (
clk : in STD_LOGIC;
rst : in STD_LOGIC;
refresh_tick : in STD_LOGIC;
value : in STD_LOGIC_VECTOR(15 downto 0);
an : out STD_LOGIC_VECTOR(3 downto 0);
seg : out STD_LOGIC_VECTOR(6 downto 0)
);
end component;

signal gate_1s_sig : STD_LOGIC := '0';
signal refresh_tick_sig : STD_LOGIC := '0';

signal btn_clean : STD_LOGIC := '0';
signal ext_sync : STD_LOGIC := '0';

signal freq_btn : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal freq_ext : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

signal selected_freq : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin

CLK_DIV : clk_divider
port map (
clk => clk100MHz,
rst => rst,
gate_1s => gate_1s_sig,
refresh_tick => refresh_tick_sig
);

DEB_BTN : debounce
port map (
clk => clk100MHz,
rst => rst,
button_in => btn_input,
button_out => btn_clean
);

SYNC_EXT : synchronizer
port map (
clk => clk100MHz,
rst => rst,
async_in => ext_input,
sync_out => ext_sync
);

BTN_COUNTER : freq_counter
port map (
clk => clk100MHz,
rst => rst,
signal_in => btn_clean,
gate_1s => gate_1s_sig,
frequency => freq_btn
);

EXT_COUNTER : freq_counter
port map (
clk => clk100MHz,
rst => rst,
signal_in => ext_sync,
gate_1s => gate_1s_sig,
frequency => freq_ext
);

process(sw, freq_btn, freq_ext)
begin
if sw = '0' then
selected_freq <= freq_btn;
else
selected_freq <= freq_ext;
end if;
end process;

DISP : seg7_mux
port map (
clk => clk100MHz,
rst => rst,
refresh_tick => refresh_tick_sig,
value => selected_freq,
an => an,
seg => seg
);

led <= selected_freq;

end Structural;
