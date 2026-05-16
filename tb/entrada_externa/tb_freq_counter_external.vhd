library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_freq_counter_external is
end tb_freq_counter_external;

architecture Behavioral of tb_freq_counter_external is

    component freq_counter
        Port (
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            signal_in : in  STD_LOGIC;
            gate_1s   : in  STD_LOGIC;
            frequency : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    signal clk_tb        : STD_LOGIC := '0';
    signal rst_tb        : STD_LOGIC := '0';
    signal ext_signal_tb : STD_LOGIC := '0';
    signal gate_1s_tb    : STD_LOGIC := '0';
    signal frequency_tb  : STD_LOGIC_VECTOR(15 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: freq_counter
        port map (
            clk       => clk_tb,
            rst       => rst_tb,
            signal_in => ext_signal_tb,
            gate_1s   => gate_1s_tb,
            frequency => frequency_tb
        );

    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_process: process
    begin
        -- Reset inicial
        rst_tb <= '1';
        wait for 100 ns;
        rst_tb <= '0';
        wait for 100 ns;

        -- Señal externa con 4 periodos
        -- Se esperan 4 flancos de subida
        for i in 1 to 4 loop
            ext_signal_tb <= '1';
            wait for 100 ns;
            ext_signal_tb <= '0';
            wait for 100 ns;
        end loop;

        -- Cierre de ventana de medición
        wait until rising_edge(clk_tb);
        gate_1s_tb <= '1';

        wait until rising_edge(clk_tb);
        gate_1s_tb <= '0';

        wait for 200 ns;

        assert unsigned(frequency_tb) = 4
        report "Error: frequency_tb no vale 4"
        severity error;

        wait for 300 ns;

        assert false report "Fin de simulacion externa" severity failure;
    end process;

end Behavioral;
