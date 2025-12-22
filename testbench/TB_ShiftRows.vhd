library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity TB_ShiftRows is
--  Port ( );
end TB_ShiftRows;

architecture Behavioral of TB_ShiftRows is
    component ShiftRows is port(
    a: in std_logic_vector(127 downto 0);
    o : out std_logic_vector(127 downto 0) 
    );end component;
    
signal a, o: std_logic_vector(127 downto 0);
begin
    uut:  ShiftRows port map(a => a, o => o);
    stim : process
    begin
          a <= x"abc8d99965668873884ad565bf865565";
            wait for 10 ns; 
   end process;

end Behavioral;
