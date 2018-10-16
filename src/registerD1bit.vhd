----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:11:47 10/14/2018 
-- Design Name: 
-- Module Name:    registerD1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerD1bit is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           load : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end registerD1bit;

architecture Behavioral of registerD1bit is
signal temp	:	std_logic;
begin
	process(clk, reset_n)
	begin
		if reset_n = '1' then
			temp <= '0';
		elsif rising_edge(clk) then
			if load = '1' then
				temp <= D;
			else
				temp <= temp;
			end if;
		else
			temp <= temp;
		end if;
	end process;
Q <= temp;
end Behavioral;

