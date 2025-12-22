library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRows is
    Port ( 
        a: in std_logic_vector(127 downto 0);
        o: out std_logic_vector(127 downto 0)
    );
end ShiftRows;

architecture Behavioral of ShiftRows is
begin
    stim: process (a)
        variable iterator : integer;
    begin

        for i in 0 to 3 loop
            for j in 0 to 3 loop
                if j - i < 0 then
                    iterator := j-i+ 4;
                else
                    iterator := j-i;
                end if;
                
                if i=0 then
                o(128 - 8*i-32 * j - 1 downto 128 - 8 * (i + 1) - 32 * j) <= a(128 - 8*i-32 * j - 1 downto 128 - 8 * (i + 1) - 32 * j);
                else
                 o(128 - 8*i-32 * iterator - 1 downto 128 - 8 * (i + 1) -32 * iterator) <= a(128 - 8*i-32 * j - 1 downto 128 - 8 * (i + 1) - 32 * j);
                end if;
              
            end loop;
        end loop;
    end process;

end Behavioral;
