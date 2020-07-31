library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_25ms is
    Port ( clk : in  STD_LOGIC;
           clk_25ms : out  STD_LOGIC);
end clock_25ms;

architecture Behavioral of clock_25ms is

signal count : STD_LOGIC_VECTOR(18 downto 0);

begin
	Freq_divider: process(clk) is 
		begin
			if(rising_edge(clk)) then
				if(count >= 300000) then
					count <= "0000000000000000000";
					clk_25ms <= '0';
				elsif(count >= 150000) then
					count <= count + 1;
					clk_25ms <= '1';
				else
					count <= count + 1;
					clk_25ms <= '0';
				end if;
			end if;
		end process Freq_divider;

end Behavioral;

