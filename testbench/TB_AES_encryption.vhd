library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_AES_encryption is
-- Port ( );
end TB_AES_encryption;

architecture Behavioral of TB_AES_encryption is
    component AES_encryption_TB is
       Port (
        clk : in std_logic;
        btnR : in STD_LOGIC;
        btnC : in STD_LOGIC;
        btnU : in STD_LOGIC;
        btnL : in STD_LOGIC;
        btnD : in STD_LOGIC;       
        seg: out std_logic_vector (6 downto 0);
        an: out std_logic_vector (3 downto 0);
        o: out std_logic_vector (127 downto 0)
    );
    end component;

    signal clk,btnR,btnC,btnU,btnL,btnD: std_logic := '0';
    signal seg: std_logic_vector (6 downto 0);
    signal an: std_logic_vector (3 downto 0);
    signal o: std_logic_vector(127 downto 0);

begin
    uut : AES_encryption_TB port map (clk => clk, btnR => btnR,btnC => btnC,btnU => btnU,btnL => btnL,btnD => btnD,seg=>seg,an=>an,o=>o);

    clock_process : process
    begin
        clk <= not clk;
        wait for 2 ns;
    end process;

    AES_process : process
    begin
        wait for 10 ns;
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 180 ns;
        
        btnU <= '1';
        wait for 10 ns;
        btnU <= '0';
        wait for 500 ns;
        
        btnR <= '1';
        wait for 10 ns;
        btnR <= '0';
        wait for 50 ns;
    
        btnU <= '1';
        wait for 10 ns;
        btnU <= '0';
        wait for 180 ns;
        
        btnR <= '1';
        wait for 10 ns;
        btnR <= '0';
        wait for 50 ns;

    
        btnL <= '1';
        wait for 10 ns;
        btnL <= '0';
        wait for 180 ns;
                
        btnR <= '1';
        wait for 10 ns;
        btnR <= '0';
        wait for 50 ns;
    
        btnL <= '1';
        wait for 10 ns;
        btnD <= '0';
        wait for 180 ns;
        
                
        btnR <= '1';
        wait for 10 ns;
        btnR <= '0';
        wait for 50 ns;
           
    end process;

end Behavioral;
