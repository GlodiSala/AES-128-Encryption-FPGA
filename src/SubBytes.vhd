library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity SubBytes is
 Port ( 
   a: in std_logic_vector(127 downto 0);
   o: out std_logic_vector(127 downto 0)
   );
   
end SubBytes;

architecture Behavioral of SubBytes is
     component S_box is port(
     byte_in : in STD_LOGIC_VECTOR (7 downto 0);
     byte_out : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

 
    begin
    looop: for i in 0 to 15 generate
       uut: S_box port map(byte_in => a(8*(i+1)-1 downto 8*i), byte_out => o(8*(i+1)-1 downto 8*i));
    end generate;
    
end Behavioral;
