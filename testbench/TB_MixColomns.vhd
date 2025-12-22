library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity TB_MixColomn is
--  Port ( );
end TB_MixColomn;

architecture Behavioral of TB_MixColomn is
    component MixColumn is port(
    a: in std_logic_vector(127 downto 0);
    o : out std_logic_vector(127 downto 0) 
    );end component;
    
signal a, o: std_logic_vector(127 downto 0);
begin
uut:  MixColumn port map(a => a, o => o);
    stim : process
    begin
          a <= x"00000000000000000000000000000001";
            wait for 10 ns; 
   end process;

end Behavioral;
