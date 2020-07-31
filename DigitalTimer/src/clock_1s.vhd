library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_1s is
    Port ( clk : in  STD_LOGIC;
           clk_1s : out  STD_LOGIC);
end clock_1s;

architecture Behavioral of clock_1s is

signal count : STD_LOGIC_VECTOR(23 downto 0);

begin
	Freq_divider: process(clk) is 
		begin
			if(rising_edge(clk)) then
				if(count >= 12000000) then
					count <= "000000000000000000000000";
					clk_1s <= '0';
				elsif(count >= 6000000) then
					count <= count + 1;
					clk_1s <= '1';
				else
					count <= count + 1;
					clk_1s <= '0';
				end if;
			end if;
		end process Freq_divider;

end Behavioral;

