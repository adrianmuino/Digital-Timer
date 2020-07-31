library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotator is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  rot_lights : out  STD_LOGIC_VECTOR (15 downto 0));
end rotator;

architecture Behavioral of rotator is
type statetype is (init, rotate);

signal state, nextstate : statetype;
signal lights, nextlights : STD_LOGIC_VECTOR (15 downto 0);

begin
	process(clk, flag) begin
		if(rising_edge(clk)) then
			if(flag = '1') then
				state <= nextstate;
				lights <= nextlights;
			else
				lights <= "0000000000000000";
			end if;
		end if;
	end process;
	
	process(state, lights) begin
		case (state) is
			when init => 
				nextstate <= rotate;
				nextlights <= "1111111100000000";		
			when rotate => 
				if(lights = "1111111100000000") then
					nextlights <= "1111111000000001";
				elsif(lights = "1111111000000001") then
					nextlights <= "1111110000000011";
				elsif(lights = "1111110000000011") then
					nextlights <= "1111100000000111";
				elsif(lights = "1111100000000111") then
					nextlights <= "1111000000001111";
				elsif(lights = "1111000000001111") then
					nextlights <= "1110000000011111";
				elsif(lights = "1110000000011111") then
					nextlights <= "1100000000111111";
				elsif(lights = "1100000000111111") then
					nextlights <= "1000000001111111";
				elsif(lights = "1000000001111111") then
					nextlights <= "0000000011111111";
				elsif(lights = "0000000011111111") then
					nextlights <= "0000000111111110";
				elsif(lights = "0000000111111110") then
					nextlights <= "0000001111111100";
				elsif(lights = "0000001111111100") then
					nextlights <= "0000011111111000";
				elsif(lights = "0000011111111000") then
					nextlights <= "0000111111110000";
				elsif(lights = "0000111111110000") then
					nextlights <= "0001111111100000";
				elsif(lights = "0001111111100000") then
					nextlights <= "0011111111000000";
				elsif(lights = "0011111111000000") then
					nextlights <= "0111111110000000";
				else
					nextlights <= "1111111100000000"; -- when lights start up "000000000000"
				end if;
				
		end case;
	end process;
	
	rot_lights <= lights;
					  
end Behavioral;

