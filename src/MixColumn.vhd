library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MixColumn is
 Port ( 
        a: in std_logic_vector(127 downto 0);
        o: out std_logic_vector(127 downto 0)
    );
end MixColumn;

architecture Behavioral of MixColumn is
 component LUT_mul2 is port(
    byte_in: in std_logic_vector(7 downto 0);
    byte_out : out std_logic_vector(7 downto 0) 
    );end component;
    component LUT_mul3 is port(
    byte_in: in std_logic_vector(7 downto 0);
    byte_out : out std_logic_vector(7 downto 0) 
    );end component;
    signal mul2, mul3: std_logic_vector(127 downto 0);

begin
    looop: for i in 0 to 15 generate
       uut2: LUT_mul2 port map(byte_in => a(8*(i+1)-1 downto 8*i), byte_out => mul2(8*(i+1)-1 downto 8*i));
       uut3: LUT_mul3 port map(byte_in => a(8*(i+1)-1 downto 8*i), byte_out => mul3(8*(i+1)-1 downto 8*i));
    end generate;

stim:process (a,mul2,mul3)
begin
     for i in 0 to 3 loop
     for j in 0 to 3 loop
            case i is
            when 0 => o(128-8*(i) - 1 - 32*j downto 128-8*(i+1)-32*j) <= mul2(128 - 1 - 32*j downto 128-8-32*j) xor mul3(128-8*1 - 1 - 32*j downto 128-8*2 - 32*j) xor a(128-2*8- 1 - 32*j downto 128-3*8- 32*j)xor a(128-3*8 - 1 - 32*j downto 128-4*8- 32*j);
            when 1 => o(128-8*(i) - 1 - 32*j downto 128-8*(i+1)-32*j)  <= a(128 - 1 - 32*j downto 128-8-32*j) xor mul2(128-8*1 - 1 - 32*j downto 128-8*2 - 32*j) xor mul3(128-2*8 - 1 - 32*j downto 128-3*8- 32*j)xor a(128-3*8- 1 - 32*j downto 128-4*8- 32*j);
            when 2 => o(128-8*(i) - 1 - 32*j downto 128-8*(i+1)-32*j)  <= a(128-1-32*j downto 128-8-32*j) xor a(128-8*1 - 1 - 32*j downto 128-8*2 - 32*j) xor mul2(128-2*8 - 1 - 32*j downto 128-3*8- 32*j)xor mul3(128-3*8 - 1 - 32*j downto 128-4*8-32*j);
            when 3 => o(128-8*(i) - 1 - 32*j downto 128-8*(i+1)-32*j)  <= mul3(128 - 1 - 32*j downto 128-8-32*j) xor a(128-8*1 - 1 - 32*j downto 128-8*2 - 32*j) xor a(128-2*8 - 1 - 32*j downto 128-8*3 - 32*j)xor mul2(128-3*8 - 1 - 32*j downto 128-4*8 - 32*j);
            end case; 
            end loop;
    end loop;
end process;
end Behavioral;
