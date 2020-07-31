library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_1ms is
    Port ( clk : in  STD_LOGIC;
           clk_1ms : out  STD_LOGIC);
end clock_1ms;

architecture Behavioral of clock_1ms is

signal count : STD_LOGIC_VECTOR(23 downto 0);

begin
	Freq_divider: process(clk) is 
		begin
			if(rising_edge(clk)) then
				if(count >= 12000) then
					count <= "000000000000000000000000";
					clk_1ms <= '0';
				elsif(count >= 6000) then
					count <= count + 1;
					clk_1ms <= '1';
				else
					count <= count + 1;
					clk_1ms <= '0';
				end if;
			end if;
		end process Freq_divider;

end Behavioral;

