----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:14:08 10/14/2018 
-- Design Name: 
-- Module Name:    ula - Behavioral 
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

entity ula is
    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           N : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end ula;

architecture Behavioral of ula is
begin
	process
		begin
		case sel is
			when "000" =>
				output <= X + Y;
			when "001" =>
				output <= X and Y;
			when "010" =>
				output <= X or Y;
			when "011" =>
				output <= not(X);
			when "100" =>
				output <= Y;
			when others =>
				output <= Y;
			end case;
		if output = "00000000" then
			Z <= '1';
		else
			Z <= '0';
		end if;
		if output(7) = '1' then
			N <= '1';
		else 
			N <= '0';
		end if;
	end process;
end Behavioral;

