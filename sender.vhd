library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity sender is
Port ( reset ,clk, en, btn, ready: in std_logic;
char : out std_logic_vector (7 downto 0);
send : out std_logic
 );
end sender;

architecture Behavioral of sender is

signal netid : std_logic_vector (5 downto 0);
signal inshift : std_logic_vector (5 downto 0);
signal i : std_logic_vector (5 downto 0);
signal h : std_logic_vector (5 downto 0);
type state_type is (R,Idel,S,busyA, busyB, busyC);
signal NS, PS : state_type;



begin
process (clk, en, ready,btn, i, h) is begin

case PS is
   when R =>
    
    if (reset ='1') 
    then
    netid <= inshift (5 downto 0);
    NS <= Idel;
    else null;
    end if;
    
    when Idel =>
    if (ready = '1' and btn = '1' and unsigned(i) < 6) 
    
    then  
        send <= '1';
        char <= netid;
          h <= h & "00001";
         i <=h;
         NS <= busyA;
         
         else if (ready = '1' and btn = '1' and unsigned(i) = 6)
         
         then
         i <= inshift (5 downto 0);
         NS <= Idel;
         else null;
         end if;
         end if;
    
   when busyA =>
   NS <= busyB;
   
   when busyB=>
   send <= '0';
   NS <= busyC;
   
   when busyC =>
   if (btn = '0' and ready = '1') then
   NS <= Idel;
   else null;
   end if;
   
   end case;
   end process;
   end behavioral;
