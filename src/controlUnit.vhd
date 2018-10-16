----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:14:07 10/14/2018 
-- Design Name: 
-- Module Name:    controlUnit - Behavioral 
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

entity controlUnit is
    Port ( 
			  clk : in STD_LOGIC;
			  reset_n : in STD_LOGIC;
			  iNOP : in  STD_LOGIC;
           iSTA : in  STD_LOGIC;
           iLDA : in  STD_LOGIC;
           iADD : in  STD_LOGIC;
           iOR : in  STD_LOGIC;
           iAND : in  STD_LOGIC;
           iNOT : in  STD_LOGIC;
           iJMP : in  STD_LOGIC;
           iJN : in  STD_LOGIC;
           iJZ : in  STD_LOGIC;
           iHLT : in  STD_LOGIC;
           cg_PC : out  STD_LOGIC;
           cg_REM : out  STD_LOGIC;
           cg_RDM : out  STD_LOGIC;
           cg_RI : out  STD_LOGIC;
           cg_AC : out  STD_LOGIC;
           cg_NZ : out  STD_LOGIC;
           inc_PC : out  STD_LOGIC;
           sel_REM : out  STD_LOGIC;
           sel_ULA : out  STD_LOGIC_VECTOR (2 downto 0);
           N : in  STD_LOGIC;
           Z : in  STD_LOGIC;
           oWrite : out  STD_LOGIC;
           oRead : out  STD_LOGIC);
end controlUnit;

architecture Behavioral of controlUnit is

type T_STATE is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13);
signal estado, proxEstado : T_STATE;
signal temp : std_logic;
signal rst	: std_logic;
signal iULA : std_logic;


begin

iULA <= iADD and iOR and iAND and iNOT and iLDA;

process(clk, reset_n)
begin
	if reset_n = '1' then 
		estado <= s0;
	elsif (rising_edge(clk)) then
		estado <= proxEstado;
	else
		estado <= estado;
	end if;
end process;

process(clk, estado, proxEstado)
begin

case estado is
	when S0 =>
		proxEstado <= S1;
	when S1 =>
		proxEstado <= S2;
	when S2 =>
		if iNOP = '1' then
			proxEstado <= S0;
		elsif iNOT = '1' then 
			proxEstado <= S3;
		elsif (iJN = '1' and N = '0') or (iJZ = '1' and Z = '0') then
			proxEstado <= S4;
		elsif iULA = '1' or iJMP = '1' or (iJN = '1' and N = '1') or (iJZ = '1' and Z ='1') or iSTA = '1' or iLDA = '1' then
			proxEstado <= S5;
		elsif iHLT = '1' then
			proxEstado <= S13;
		else
			proxEstado <= S13;
		end if;
	when S3 =>
		proxEstado <= S0;
	when S4 =>
		proxEstado <= S0;
	when S5 =>
		if iJMP = '1' or (iJN = '1' and N = '1') or (iJZ = '1' and Z = '1') then
			proxEstado <= S6;
		elsif iULA = '1' or iLDA = '1' or iSTA = '1' then
			proxEstado <= S8;
		else
			proxEstado <= S13;
		end if;
	when S6 => 
		proxEstado <= S7;
	when S7 =>
		proxEstado <= S0;
	when S8 =>
		proxEstado <= S9;
	when S9 =>
		if iSTA = '1' then
			proxEstado <= S10;
		elsif iLDA = '1' or iULA = '1' then
			proxEstado <= S11;
		else 
			proxEstado <= S12;
		end if;
	when S10 =>
		proxEstado <= S0;
	when S11 =>
		proxEstado <= S12;
	when S12 => 
		proxEstado <= S0;
	when others =>
		proxEstado <= S13;
	end case;
end process;

process(estado)
begin
	case estado is
		when S0 =>
			sel_REM <= '0';
			cg_REM <= '1';
		when S1 =>
			inc_PC <= '1';
			cg_RDM <= '1';
		when S2 =>
			cg_RI <= '1';
		when S3 =>
			sel_ULA <= "011"; --ULA(NOT)
			cg_AC <= '1';
			cg_NZ <= '1';
		when S4 =>
			inc_PC <= '1';
		when S5 =>
			sel_REM <= '0';
			cg_REM <= '1';
		when S6 =>
			oRead <= '1';
			cg_RDM <= '1';
		when S7 =>
			cg_PC <= '1';
		when S8 =>
			oRead <= '1';
			cg_RDM <= '1';
			inc_PC <= '1';
		when S9 =>
			sel_REM <= '1';
			cg_REM <= '1';
		when S10 =>
			oWrite <= '1';
		when S11 =>
			oRead <= '1';
			cg_RDM <= '1';
		when S12 =>
			cg_AC <= '1';
			cg_NZ <= '1';
			if iLDA = '1' then
				sel_ULA <= "100"; --ULA(LDA)
			elsif iOR = '1' then
				sel_ULA <= "010"; --ULA(OR)
			elsif iAND = '1' then
				sel_ULA <= "001"; --ULA(AND)
			elsif iADD = '1' then
				sel_ULA <= "000"; --ULA(ADD)
			else
				sel_ULA <= "000";
			end if;
		when others =>
			inc_PC <= '0'; --default case inutil
	end case;
end process;

end Behavioral;

