----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:41 10/14/2018 
-- Design Name: 
-- Module Name:    Neander - Behavioral 
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

entity Neander is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC);
end Neander;

architecture Behavioral of Neander is

	signal mux_rem : std_logic;
	
	COMPONENT programCounter
		PORT( 
			clk : IN STD_LOGIC;
			reset_n : IN STD_LOGIC;
			load : IN STD_LOGIC;
			inc : IN STD_LOGIC;
			D : IN STD_LOGIC;
			Q : OUT STD_LOGIC
		); 
	END COMPONENT;
	
	COMPONENT registerD1bit
		PORT ( 
			clk : in  STD_LOGIC;
         reset_n : in  STD_LOGIC;
         load : in  STD_LOGIC;
         D : in  STD_LOGIC;
         Q : out  STD_LOGIC_VECTOR
		);
	END COMPONENT;
	
	COMPONENT registerD8bit
		PORT ( 
			clk : in  STD_LOGIC;
         reset_n : in  STD_LOGIC;
         load : in  STD_LOGIC;
         D : in  STD_LOGIC_VECTOR (7 downto 0);
         Q : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT decod16p1
		PORT ( 
			opcode : in  STD_LOGIC_VECTOR (15 downto 0);
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
			iHLT : out  STD_LOGIC
		);
	END COMPONENT;	
	
	COMPONENT controlUnit
		PORT ( 
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
			oRead : out  STD_LOGIC
		);
	END COMPONENT;

	COMPONENT ula
		PORT ( 
			X : in  STD_LOGIC_VECTOR (7 downto 0);
			Y : in  STD_LOGIC_VECTOR (7 downto 0);
			sel : in  STD_LOGIC_VECTOR (3 downto 0);
			N : out  STD_LOGIC;
			Z : out  STD_LOGIC;
			output : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;	
	
begin

	PC : programCounter PORT MAP(
		clk => clk,
		reset_n => reset_n,
		load => cg_PC,
		inc => inc_PC,
		D => out_RDM,
		Q => out_PC
	);
		
	r_REM : registerD8bit PORT MAP(
		clk => clk,
		reset_n => reset_n,
		load => cg_REM,
		D => mux_rem,
		Q => out_REM
	);
		
	r_RDM : registerD8bit PORT MAP(
		clk => clk,
		reset_n => reset_n,
		load => cg_RDM,
		D => out_MEM,
		Q => out_RDM
	);
	
	r_AC : registerD8bit PORT MAP(
		clk => clk,
		reset_n => reset_n,
		load => cg_AC,
		D => out_ULA,
		Q => out_AC
	);
	
	ULA : ula PORT MAP(
		X => out_AC,
		Y => out_RDM,
		sel => sel_ULA,
		N => N,
		Z => Z,
		output => out_ULA
	);
		
	r_N : registerD1bit PORT MAP (
		clk => clk,
		reset_n => reset_n,
		load => cg_NZ,
		D => N,
		Q => out_N
	);
	
	r_Z : registerD1bit PORT MAP (
		clk => clk,
		reset_n => reset_n,
		load => cg_NZ,
		D => Z,
		Q => out_Z
	);
	
	r_RI : registerD8bit PORT MAP (
		clk => clk,
		reset_n => reset_n,
		load => cg_RI,
		D => out_RDM,
		Q => out_RI
	);
	
	decoder : decod4p16 PORT MAP (
		opcode => outRI(7 downto 4),
		iNOP => oNOP,
		iSTA => oSTA,
		iLDA => oLDA,
		iADD => oADD,
		iOR => oOR,
		iAND => oAND,
		iNOT => oNOT,
		iJMP => oJMP,
		iJN => oJN,
		iJZ => oJZ,
		iHLT => oHLT
	);
	
	UC : controlUnit PORT MAP(
		clk => clk,
		reset_n => reset_n,
		iNOP => oNOP,
		iSTA => oSTA,
		iLDA => oLDA,
		iADD => oADD,
		iOR => oOR,
		iAND => oAND,
		iNOT => oNOT,
		iJMP => oJMP,
		iJN => oJN,
		iJZ => oJZ,
		iHLT => oHLT,
		cg_PC => cg_PC,
		cg_REM => cg_REM,
		cg_RDM => cg_RDM,
		cg_RI => cg_RI,
		cg_AC => cg_AC,
		cg_NZ => cg_NZ,
		inc_PC => inc_PC,
		sel_REM => sel_REM,
		sel_ULA => sel_ULA,
		N => out_N,
		Z => out_Z,
		oWrite => iWrite,
		oRead => iRead
	);
	
	mux_rem <= (out_PC and not(sel_REM)) or (out_RDM and sel_REM); -- Sum of product mux implementation



end Behavioral;

