----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:56:27 10/14/2018 
-- Design Name: 
-- Module Name:    decod4p16 - Behavioral 
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

entity decod4p16 is
    Port ( opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           oNOP : out  STD_LOGIC;
           oSTA : out  STD_LOGIC;
           oLDA : out  STD_LOGIC;
           oADD : out  STD_LOGIC;
           oOR : out  STD_LOGIC;
           oAND : out  STD_LOGIC;
           oNOT : out  STD_LOGIC;
           oJMP : out  STD_LOGIC;
           oJN : out  STD_LOGIC;
           oJZ : out  STD_LOGIC;
           oHLT : out  STD_LOGIC);
end decod4p16;

architecture Behavioral of decod4p16 is

begin

process(opcode)
begin
	oNOP <= '0';
	oSTA <= '0';
	oLDA <= '0';
	oADD <= '0';
	oOR <= '0';
	oAND <= '0';
	oNOT <= '0';
	oJMP <= '0';
	oJN <= '0';
	oJZ <= '0';
	oHLT <= '0';
	case opcode is
		when "0000" =>
			oNOP <= '1';
		when "0001" =>
			oSTA <= '1';
		when "0010" =>
			oLDA <= '1';
		when "0011" =>
			oADD <= '1';
		when "0100" =>
			oOR <= '1';
		when "0101" =>
			oAND <= '1';
		when "0110" =>
			oNOT <= '1';
		when "1000" =>
			oJMP <= '1';
		when "1001" =>
			oJN <= '1';
		when "1010" =>
			oJZ <= '1';
		when "1111" =>
			oHLT <= '1';
		when others =>
			oHLT <= '1';
	end case;
end process;

end Behavioral;

