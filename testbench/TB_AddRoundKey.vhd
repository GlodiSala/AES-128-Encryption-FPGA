library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity TB_AddRoundKey is
--  Port ( );
end TB_AddRoundKey;

architecture ben of TB_AddRoundKey is
component AddRoundKey is port(
a, k: in std_logic_vector(127 downto 0);
o : out std_logic_vector(127 downto 0) 
);end component;
-- These are the internal wires
signal a, k, o: std_logic_vector(127 downto 0);
begin
    uut : AddRoundKey port map(a => a, k=>k, o => o);
    stim : process
    variable inputs1 : std_logic_vector( 127 downto 0);
    variable inputs2 : std_logic_vector( 127 downto 0);
    begin
        for i in 0 to 2**8 - 1 loop
            for j in 0 to 2**8 - 1 loop
                inputs1 := std_logic_vector(to_unsigned(i, inputs1'length));
                inputs2 := std_logic_vector(to_unsigned(j, inputs2'length));
                a<= inputs1; k<=inputs2;
                wait for 10 ns; 
                end loop;
        end loop;
    end process;
end ben;
