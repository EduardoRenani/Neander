----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:49:43 10/14/2018 
-- Design Name: 
-- Module Name:    decod16p1 - Behavioral 
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

entity decod16p1 is
    Port ( opcode : in  STD_LOGIC_VECTOR (15 downto 0);
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
end decod16p1;

architecture Behavioral of decod16p1 is

begin

process(clk,opcode)
begin

case(opcode()) is:
	when 

end process;

end Behavioral;

