----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2019 09:07:01 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity uart_tx is
 Port ( clk, en, send, rst :in std_logic;
 charS :in std_logic_vector (5 downto 0);
 ready, tx : out std_logic
 );
end uart_tx;

architecture Behavioral of uart_tx is

signal inshift : std_logic_vector (5 downto 0);
type state_type is (R,I,S);
signal PS, NS : state_type;
signal reg : std_logic_vector (5 downto 0);

begin
process (clk, send, en) is begin

case PS is
    
    when R =>

    reg <= inshift (5 downto 0);

    when I =>
    
    ready <= '1';
    NS <= S;
    
    when S =>
    
    if (rising_edge(clk) and send = '1' and en = '1')
                  
    then
    
    reg <= charS;
    reg <= inshift (5 downto 0); 
    
       
    end if;
        end case;
    end process;
    