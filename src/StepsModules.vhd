library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity StepsModules is
 Port (
        clk : in std_logic;
        a : in std_logic_vector(127 downto 0);
        o : out std_logic_vector(127 downto 0);
        rst : in std_logic
    );
end StepsModules;

architecture Behavioral of StepsModules is
component AddRoundKey is 
        port ( 
            k: in std_logic_vector(127 downto 0);
            a: in std_logic_vector(127 downto 0);
            o: out std_logic_vector(127 downto 0)
        );
    end component;   
    component SubBytes is 
        port ( 
            a: in std_logic_vector(127 downto 0);
            o: out std_logic_vector(127 downto 0)
        );
    end component;

    component ShiftRows is 
        port ( 
            a: in std_logic_vector(127 downto 0);
            o: out std_logic_vector(127 downto 0)
        );
    end component;
   
    component MixColumn is 
        port ( 
            a: in std_logic_vector(127 downto 0);
            o: out std_logic_vector(127 downto 0)
        );
    end component;
    
    type statetype is (SB, SR, MC, ARK,RSTT);
    signal currentState : statetype := ARK;
    signal nextState : statetype := ARK;
    signal o1, o2, o3, o4 : std_logic_vector(127 downto 0);
    signal i1, i2, i3, i4, k1 : std_logic_vector(127 downto 0);
    signal input_i: std_logic_vector(127 downto 0);
    signal input_k: std_logic_vector(127 downto 0);


begin
  
    subbyte_inst : SubBytes port map(a => i1, o => o1);
    shiftrow_inst : ShiftRows port map(a => i2, o => o2);
    mixcolomn_inst : MixColumn port map(a => i3, o => o3);
    addrondkey_inst : AddRoundKey port map(k => k1, a => i4, o => o4);

    

   state_proc: process (currentState)
        variable counter : integer range 0 to 10 := 1;  

    begin
        
            case currentState is
                when RSTT =>
                i4<=a;
                k1<=x"2b7e151628aed2a6abf7158809cf4f3c";
                nextState<=ARK;
                 o <= (others => '0');
                counter :=0;
                when SB =>
                    i2 <= o1;
                    nextState <= SR;
                    o <= o1;  
                                   
                when SR =>   
                    o <= o2;
                    if counter = 10 then
                    k1 <= x"d014f9a8c9ee2589e13f0cc8b6630ca6";
                    i4<=o2;
                    nextState <= ARK;
                    else
                     nextState <= MC;
                      i3 <= o2;
                     end if;                                       
                when MC =>
                    o <= o3;
                    nextState <= ARK;                   
                case counter is
                when 1 =>
                    k1 <= x"a0fafe1788542cb123a339392a6c7605";
                when 2 =>
                    k1 <= x"f2c295f27a96b9435935807a7359f67f";
                when 3 =>
                    k1 <= x"3d80477d4716fe3e1e237e446d7a883b";
                when 4 =>
                    k1 <= x"ef44a541a8525b7fb671253bdb0bad00";
                when 5 =>
                    k1 <= x"d4d1c6f87c839d87caf2b8bc11f915bc";
                when 6 =>
                    k1 <= x"6d88a37a110b3efddbf98641ca0093fd";
                when 7 =>
                    k1 <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f";
                when 8 =>
                    k1 <= x"ead27321b58dbad2312bf5607f8d292f";
                when 9 =>
                    k1 <= x"ac7766f319fadc2128d12941575c006e";                                                       
                when others =>
                    k1 <= (others => '0');
                  end case;
                       i4 <= o3;                                  
                when ARK =>
                    counter :=counter+1;                     
                     o <= o4;
                     i1<= o4;
                    if counter < 11 then
                    nextState <= SB;
                    else
                     nextState <=ARK;
                    end if;                   
            end case;
        
    end process;

clk_proc : process (clk, rst)
    begin
        if rst = '1' then
            currentState <= RSTT;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;



end Behavioral;
