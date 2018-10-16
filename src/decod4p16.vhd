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
           iNOP : out  STD_LOGIC;
           iSTA : out  STD_LOGIC;
           iLDA : out  STD_LOGIC;
           iADD : out  STD_LOGIC;
           iOR : out  STD_LOGIC;
           iAND : out  STD_LOGIC;
           iNOT : out  STD_LOGIC;
           iJMP : out  STD_LOGIC;
           iJN : out  STD_LOGIC;
           iJZ : out  STD_LOGIC;
           iHLT : out  STD_LOGIC);
end decod4p16;

architecture Behavioral of decod4p16 is

begin

process(opcode)
begin
	iNOP <= '0';
	iSTA <= '0';
	iLDA <= '0';
	iADD <= '0';
	iOR <= '0';
	iAND <= '0';
	iNOT <= '0';
	iJMP <= '0';
	iJN <= '0';
	iJZ <= '0';
	iHLT <= '0';
	case opcode is
		when "0000" =>
			iNOP <= '1';
		when "0001" =>
			iSTA <= '1';
		when "0010" =>
			iLDA <= '1';
		when "0011" =>
			iADD <= '1';
		when "0100" =>
			iOR <= '1';
		when "0101" =>
			iAND <= '1';
		when "0110" =>
			iNOT <= '1';
		when "1000" =>
			iJMP <= '1';
		when "1001" =>
			iJN <= '1';
		when "1010" =>
			iJZ <= '1';
		when "1111" =>
			iHLT <= '1';
		when others =>
			iHLT <= '1';
	end case;
end process;

end Behavioral;

