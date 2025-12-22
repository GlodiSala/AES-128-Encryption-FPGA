library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_StepsModules is
--  Port ( );
end TB_StepsModules;

architecture Behavioral of TB_StepsModules is
component StepsModules is
        port(
        clk : in std_logic;
        a : in std_logic_vector(127 downto 0);
        o : out std_logic_vector(127 downto 0);
        rst : in std_logic
    );
    end component;

    signal clk,rst: std_logic := '0';
    signal a,o: std_logic_vector(127 downto 0);

begin
    uut : StepsModules port map (clk => clk, a => a, o => o,rst=>rst);

    clock_process : process
    begin
        clk <= not clk;
        wait for 2 ns;
    end process;

    AES_process : process
    begin
    
        rst <='1' ;
        a <= x"6BC1BEE22E409F96E93D7E117393172A";
        wait for 5 ns;
        rst <= '0';
        wait for 180 ns;
        rst <= '1';
        a<= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
        wait for 5 ns;
        rst <= '0';
        wait for 180 ns;
        rst <= '1';
        a<= x"30C81C46A35CE411E5FBC1191A0A52EF";
        wait for 5 ns;
        rst <= '0';
        wait for 180 ns;
        rst <= '1';
        a<= x"F69F2445DF4F9B17AD2B417BE66C3710";
        wait for 5 ns;
        rst <= '0';
        wait for 180 ns;
    end process;

end Behavioral;

