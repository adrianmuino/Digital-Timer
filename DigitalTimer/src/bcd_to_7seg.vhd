library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_7seg is
    Port ( num : in  STD_LOGIC_VECTOR (3 downto 0);
           SevenSD : out  STD_LOGIC_VECTOR (7 downto 0));
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is

begin
	with num select SevenSD <= 
		"00000011" when "0000",
		"10011111" when "0001",
		"00100101" when "0010",
		"00001101" when "0011",
		"10011001" when "0100",
		"01001001" when "0101",
		"01000001" when "0110",
		"00011111" when "0111",
		"00000001" when "1000",
		"00001001" when "1001",
		"00000011" when others;

end Behavioral;