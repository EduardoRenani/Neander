----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:49 10/14/2018 
-- Design Name: 
-- Module Name:    REM - Behavioral 
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

entity REM is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           load : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end REM;

architecture Behavioral of REM is
signal temp	:	std_logic_vector (7 downto 0);
begin
	process(clk, reset_n)
	begin
		if reset_n = '1' then
			temp <= "00000000";
		elsif rising_edge(clk) then
			if load = '1' then
				temp <= D;
			else
				temp <= temp;
			end if;
		else
		end if;
	end process;
Q <= temp;
end Behavioral;

