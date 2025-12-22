library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity AES_encryption is
    Port (
        clk : in std_logic;
        btnR : in STD_LOGIC;
        btnC : in STD_LOGIC;
        btnU : in STD_LOGIC;
        btnL : in STD_LOGIC;
        btnD : in STD_LOGIC;       
        seg: out std_logic_vector (6 downto 0);
        an: out std_logic_vector (3 downto 0)
    );
end AES_encryption;

architecture Behavioral of AES_encryption is
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
    
    type statetype is (SB, SR, MC, ARK,RSTT,BTNRR);
    signal currentState : statetype := RSTT;
    signal nextState : statetype := ARK;
    signal o1, o2, o3, o4,o : std_logic_vector(127 downto 0);
    signal i1, i2, i3, i4, k1,mux : std_logic_vector(127 downto 0);
    signal input_i: std_logic_vector(127 downto 0);
    signal refresh_counter: std_logic_vector(19 downto 0):= (others => '0');
    signal SEG_active_Count: std_logic_vector(1 downto 0);
    signal activate: std_logic:='0';
    signal pressed: std_logic_vector(1 downto 0):="00";
   



begin
  
    subbyte_inst : SubBytes port map(a => i1, o => o1);
    shiftrow_inst : ShiftRows port map(a => i2, o => o2);
    mixcolomn_inst : MixColumn port map(a => i3, o => o3);
    addrondkey_inst : AddRoundKey port map(k => k1, a => i4, o => o4);
   


    SEG_active_Count <= refresh_counter(19 downto 18);
   
    
    process_mux:process(clk)
     variable btn:std_logic_vector(4 downto 0):="00000";
    begin
    if (rising_edge(clk)) then
        btn := btnC &btnU &btnL &btnD &btnR;
        
               case btn is 
                when "10000" =>
                    mux<= x"6BC1BEE22E409F96E93D7E117393172A";
                    pressed <="01";
                    when "01000" =>
                    mux<= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
                    pressed <="01";
                    when "00100" =>
                    mux<= x"30C81C46A35CE411E5FBC1191A0A52EF";
                    pressed <="01";
                    when "00010"=>
                    mux<= x"F69F2445DF4F9B17AD2B417BE66C3710";
                    pressed <="01";
                    when "00001" =>
                    pressed <="10";
                    when others=>
                    pressed<="00";
                 end case;
    end if;
    
    end process;

    
   
   state_proc: process (currentState,pressed)
        variable counter : integer := 1;  

    begin
        
            case currentState is
                when RSTT =>
                if (pressed="01") then
                i4<=mux;
                 k1<=x"2b7e151628aed2a6abf7158809cf4f3c";
                 nextState<=ARK;
                counter :=0;   
                else
                activate <='0';
                o <= (others => '0');
                nextState<=RSTT; 
                             
                end if;
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
                when 1 => k1 <= x"a0fafe1788542cb123a339392a6c7605";
                when 2 =>k1 <= x"f2c295f27a96b9435935807a7359f67f";
                when 3 =>k1 <= x"3d80477d4716fe3e1e237e446d7a883b";
                when 4 => k1 <= x"ef44a541a8525b7fb671253bdb0bad00";
                when 5 =>k1 <= x"d4d1c6f87c839d87caf2b8bc11f915bc";
                when 6 =>k1 <= x"6d88a37a110b3efddbf98641ca0093fd";
                when 7 =>k1 <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f";
                when 8 =>k1 <= x"ead27321b58dbad2312bf5607f8d292f";
                when 9 =>k1 <= x"ac7766f319fadc2128d12941575c006e";                                                       
                when others =>k1 <= (others => '0');
                end case;
                       i4 <= o3;                                  
                when ARK =>
                    counter :=counter+1;                    
                     o <= o4;
                     i1<= o4;
                    if counter < 11 then
                        nextState <= SB;
                    else
                       activate<='1';      
                       nextState <=BTNRR;                                                     
                    end if;
                  when BTNRR =>
                   if pressed="10" then                    
                        nextState <=RSTT;
                        activate <='0';
                    else                    
                        nextState <=BTNRR; 
                    end if; 
                  end case;       
    end process;
    
    
    process(SEG_active_Count,activate)
        begin
        if activate ='1' then
        case SEG_active_Count is
        when "00" => an <= "0111";
            seg <= "1111111";
        when "01" => an <= "1011";
            seg <= "0001000";
        when "10" => an <= "1101";
            seg <= "0000110";
        when "11" => an <= "1110";
            seg <= "0010010";
        when others => an <="1111";      
            seg <= "1111111";           
        end case;
        else
            an <="1111";
            seg <= "1111111";

        end if;
end process;

    clk_proc : process (clk) 
    begin           
            if rising_edge(clk) then
                    currentState <= nextState;
                    refresh_counter <= refresh_counter + 1;
                end if;              
    end process;

end Behavioral;