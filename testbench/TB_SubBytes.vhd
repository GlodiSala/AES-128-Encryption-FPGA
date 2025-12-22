library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity TB_SubBytes is
--  Port ( );
end TB_SubBytes;

architecture Behavioral of TB_SubBytes is
    component SubBytes is port(
    a: in std_logic_vector(127 downto 0);
    o : out std_logic_vector(127 downto 0) 
    );end component;
signal a, o: std_logic_vector(127 downto 0);
begin
    uut : SubBytes port map(a => a, o => o);
    stim : process
    variable inputs1 : std_logic_vector( 127 downto 0);
    begin
        for i in 0 to 2**8 - 1 loop
            inputs1 := std_logic_vector(to_unsigned(i, inputs1'length));
            a<= inputs1;
            wait for 10 ns; 
            end loop;
    end process;

end Behavioral;
