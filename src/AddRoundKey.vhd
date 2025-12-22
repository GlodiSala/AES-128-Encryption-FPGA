library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddRoundKey is
   Port ( 
   k: in std_logic_vector(127 downto 0);
   a: in std_logic_vector(127 downto 0);
   o: out std_logic_vector(127 downto 0)
   );
end AddRoundKey;

architecture Behavioral of AddRoundKey is

begin
    o <= (a xor k);
end Behavioral;
