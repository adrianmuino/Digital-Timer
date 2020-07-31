library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity countdownFSM is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  sec_ones : in  STD_LOGIC_VECTOR (3 downto 0);
			  sec_tens : in  STD_LOGIC_VECTOR (3 downto 0);
			  mins : in  STD_LOGIC_VECTOR (3 downto 0);
			  output1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output3 : out  STD_LOGIC_VECTOR (3 downto 0));
end countdownFSM;

architecture Behavioral of countdownFSM is

signal nextsecs_ones : STD_LOGIC_VECTOR (3 downto 0);
signal nextsecs_tens : STD_LOGIC_VECTOR (3 downto 0);
signal nextmin : STD_LOGIC_VECTOR (3 downto 0);

begin
	process(clk, flag, sec_ones, sec_tens, mins) begin
		if(flag = '0') then
			nextsecs_ones <= sec_ones;
			nextsecs_tens <= sec_tens;
			nextmin <= mins;
		elsif(rising_edge(clk)) then
			if((sec_ones > 0) and (sec_tens >= 0) and (mins >= 0)) then
				nextsecs_ones <= sec_ones - 1;
				nextsecs_tens <= sec_tens;
				nextmin <= mins;
			elsif((sec_ones = 0) and (sec_tens > 0) and (mins >= 0)) then
				nextsecs_ones <= "1001";
				nextsecs_tens <= sec_tens - 1;
				nextmin <= mins;
			elsif((sec_ones = 0) and (sec_tens = 0) and (mins > 0)) then
				nextsecs_ones <= "1001";
				nextsecs_tens <= "0101";
				nextmin <= mins - 1;
			else
				nextsecs_ones <= "0000";
				nextsecs_tens <= "0000";
				nextmin <= "0000";
			end if;
		end if;
	end process;
					
	output1 <= nextsecs_ones;
	output2 <= nextsecs_tens;
	output3 <= nextmin;
					
end Behavioral;