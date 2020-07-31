library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addtimeFSM is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  Bone : in  STD_LOGIC;
			  Bten : in  STD_LOGIC;
			  Bmin : in  STD_LOGIC;
			  output1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output3 : out  STD_LOGIC_VECTOR (3 downto 0));
end addtimeFSM;

architecture Behavioral of addtimeFSM is
type statetype is (Init, BWait, AddSec_Ones, AddSec_Tens, AddMin, Debounce);

signal state, nextstate : statetype;
signal secs_ones, nextsecs_ones : STD_LOGIC_VECTOR (3 downto 0);
signal secs_tens, nextsecs_tens : STD_LOGIC_VECTOR (3 downto 0);
signal min, nextmin : STD_LOGIC_VECTOR (3 downto 0);

signal clk_count, nextclk_count : STD_LOGIC_VECTOR (2 downto 0);

begin
	process(clk, flag) begin
		if(flag = '0') then
			state <= Init;
		elsif(rising_edge(clk)) then
				state <= nextstate;
				secs_ones <= nextsecs_ones;
				secs_tens <= nextsecs_tens;
				min <= nextmin;
				clk_count <= nextclk_count;
		end if;
	end process;
	
	process(state, Bone, Bten, Bmin, secs_ones, secs_tens, min, clk_count) begin
		case (state) is
			when Init =>
				nextsecs_ones <= "0000";
				nextsecs_tens <= "0000";
				nextmin <= "0000";
				nextclk_count <= "000";
				nextstate <= BWait;
			when BWait =>
				if((Bone = '0') and (Bten = '1') and (Bmin = '1')) then
					nextstate <= AddSec_Ones;
				elsif((Bone = '1') and (Bten = '0') and (Bmin = '1')) then
					nextstate <= AddSec_Tens;
				elsif((Bone = '1') and (Bten = '1') and (Bmin = '0')) then
					nextstate <= AddMin;
				else
					nextstate <= BWait;
				end if;
				nextclk_count <= "000";
				nextsecs_ones <= secs_ones;
				nextsecs_tens <= secs_tens;
				nextmin <= min;		
			when AddSec_Ones => 
				if((secs_ones >= 9)) then  --"1000"
					nextsecs_ones <= "0000";  --"0000"
				else
					nextsecs_ones <= secs_ones + 1;
				end if;
				nextsecs_tens <= secs_tens;
				nextmin <= min;
				nextstate <= Debounce;
				nextclk_count <= "000";
			when AddSec_Tens => 
				if((secs_tens >= 5)) then  --"1000"
					nextsecs_tens <= "0000";  --"0000"
				else
					nextsecs_tens <= secs_tens + 1;
				end if;
				nextsecs_ones <= secs_ones;
				nextmin <= min;
				nextstate <= Debounce;
				nextclk_count <= "000";
			when AddMin => 
				if((min >= 9)) then  --"1000"
					nextmin <= "0000";  --"0000"
				else
					nextmin <= min + 1;
				end if;
				nextsecs_ones <= secs_ones;
				nextsecs_tens <= secs_tens;
				nextstate <= Debounce;
				nextclk_count <= "000";
			when Debounce =>
				if(clk_count > 4) then  -- 4 in decimal
					nextstate <= BWait;
				else
					nextstate <= Debounce;
				end if;
				nextsecs_ones <= secs_ones;
				nextsecs_tens <= secs_tens;
				nextmin <= min;
				nextclk_count <= clk_count + 1;
		end case;
	end process;
	
	output1 <= secs_ones;
	output2 <= secs_tens;
	output3 <= min;
					  
end Behavioral;

