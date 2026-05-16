library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_freq_counter_button is
end tb_freq_counter_button;

architecture Behavioral of tb_freq_counter_button is

    component freq_counter
        Port (
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            signal_in : in  STD_LOGIC;
            gate_1s   : in  STD_LOGIC;
            frequency : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    signal clk_tb       : STD_LOGIC := '0';
    signal rst_tb       : STD_LOGIC := '0';
    signal button_tb    : STD_LOGIC := '0';
    signal gate_1s_tb   : STD_LOGIC := '0';
    signal frequency_tb : STD_LOGIC_VECTOR(15 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: freq_counter
        port map (
            clk       => clk_tb,
            rst       => rst_tb,
            signal_in => button_tb,
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
        rst_tb <= '1';
        wait for 100 ns;
        rst_tb <= '0';
        wait for 100 ns;

        -- Pulso 1
        button_tb <= '1';
        wait for 100 ns;
        button_tb <= '0';
        wait for 200 ns;

        -- Pulso 2
        button_tb <= '1';
        wait for 100 ns;
        button_tb <= '0';
        wait for 200 ns;

        -- Pulso 3
        button_tb <= '1';
        wait for 100 ns;
        button_tb <= '0';
        wait for 200 ns;

        -- Pulso 4
        button_tb <= '1';
        wait for 100 ns;
        button_tb <= '0';
        wait for 200 ns;

        -- Pulso 5
        button_tb <= '1';
        wait for 100 ns;
        button_tb <= '0';
        wait for 200 ns;

        -- Cierre de ventana de medición
        wait until rising_edge(clk_tb);
        gate_1s_tb <= '1';

        wait until rising_edge(clk_tb);
        gate_1s_tb <= '0';

        wait for 200 ns;

        assert unsigned(frequency_tb) = 5
        report "Error: frequency_tb no vale 5"
        severity error;

        wait for 500 ns;

        assert false report "Fin de simulacion boton" severity failure;
    end process;

end Behavioral;
