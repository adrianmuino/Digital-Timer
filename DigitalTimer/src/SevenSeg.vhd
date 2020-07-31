library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Seven_Seg is
    Port ( clk : in STD_LOGIC;
			  Bone : in  STD_LOGIC;
			  Bten : in  STD_LOGIC;
			  Bmin : in  STD_LOGIC;
			  Enter : in STD_LOGIC;
			  Reset : in STD_LOGIC;
			  Enable : out STD_LOGIC_VECTOR (2 downto 0);
           SevenSD : out  STD_LOGIC_VECTOR (7 downto 0);
			  LED : out STD_LOGIC_VECTOR (7 downto 0));
end Seven_Seg;

architecture Structural of Seven_Seg is
	
	component clock_1s is
    Port ( clk : in  STD_LOGIC;
           clk_1s : out  STD_LOGIC);
	end component;
	
	component clock_25ms is
    Port ( clk : in  STD_LOGIC;
           clk_25ms : out  STD_LOGIC);
	end component;
	
	component clock_1ms is
    Port ( clk : in  STD_LOGIC;
           clk_1ms : out  STD_LOGIC);
	end component;
	
	component rotator is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  rot_lights : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
																					--------
	component addtimeFSM is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  Bone : in  STD_LOGIC;
			  Bten : in  STD_LOGIC;
			  Bmin : in  STD_LOGIC;
			  output1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output3 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;	
	
	component countdownFSM is
    Port ( clk: in STD_LOGIC;
			  flag : in STD_LOGIC;
			  sec_ones : in  STD_LOGIC_VECTOR (3 downto 0);
			  sec_tens : in  STD_LOGIC_VECTOR (3 downto 0);
			  mins : in  STD_LOGIC_VECTOR (3 downto 0);
			  output1 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  output3 : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component bcd_to_7seg is
    Port ( num : in  STD_LOGIC_VECTOR (3 downto 0);
           SevenSD : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
																				------------
	type statetype is (Init, Sample, SubSeconds, Finish); --------------------------------------
	signal state, nextstate : statetype;
	
	type enabletype is (NoDigit, Digit1, Digit2, Digit3);
	signal en: enabletype;
	
	--Clock Signals
	signal clk_25ms : STD_LOGIC;
	signal clk_1ms : STD_LOGIC;
	signal clk_1s : STD_LOGIC;
	
	--Rotating Light Signals
	signal lights: STD_LOGIC_VECTOR(15 downto 0);
	
	--Flags
	signal inc_time_flag : STD_LOGIC;
	signal dec_time_flag : STD_LOGIC;
	signal led_flag: STD_LOGIC;
	
	--Hex Display Numbers
	
	signal sec_ones, sec_tens, mins: STD_LOGIC_VECTOR(3 downto 0);
	signal inc_sec_ones, inc_sec_tens, inc_mins: STD_LOGIC_VECTOR(3 downto 0);
	signal dec_sec_ones, dec_sec_tens, dec_mins: STD_LOGIC_VECTOR(3 downto 0);
	signal Display_Ones, Display_Tens, Display_Mins : STD_LOGIC_VECTOR (7 downto 0);
	signal Display_Ones_Dec, Display_Tens_Dec, Display_Mins_Dec : STD_LOGIC_VECTOR (7 downto 0);
	
begin
	--Clocks
	Clk_25msec:clock_25ms port map(clk, clk_25ms);
	Clk_1msec:clock_1ms port map(clk, clk_1ms);
	Clk_1sec:clock_1s port map(clk, clk_1s);
	
	--Increase Time FSM
	IncTime:addTimeFSM port map(clk_25ms, inc_time_flag, Bone, Bten, Bmin, inc_sec_ones, inc_sec_tens, inc_mins); ----------------
	
	--Increase Time FSM
	DecTime:countdownFSM port map(clk_1s, dec_time_flag, sec_ones, sec_tens, mins, dec_sec_ones, dec_sec_tens, dec_mins); ----------------
	
	--Light Rotator FSM
	Rotate:rotator port map(clk_25ms, led_flag, lights);
	
	--Binary Coded Decimal To Hex Display Converter
	Second_Ones:bcd_to_7seg port map(sec_ones, Display_Ones);
	Second_Tens:bcd_to_7seg port map(sec_tens, Display_Tens);
	Minutes:bcd_to_7seg port map(mins, Display_Mins);
	
	--State Register
	process(clk, Reset) begin
		if(Reset = '0') then
			state <= Init;
		elsif(rising_edge(clk)) then
			state <= nextstate;
		end if;
	end process;
	
	-- Next State Logic                          -------------------------------
	process(state, Enter)	begin				
		case(state) is
			when Init =>
				nextstate <= Sample;
				inc_time_flag <= '0';
				dec_time_flag <= '0';
				led_flag <= '0';
			when Sample =>
				if(Enter = '0') then
					nextstate <= SubSeconds;
				else
					nextstate <= Sample;
				end if;
				sec_ones <= inc_sec_ones;
				sec_tens <= inc_sec_tens;
				mins <= inc_mins;
				inc_time_flag <= '1';
				dec_time_flag <= '0';
				led_flag <= '0';
			when SubSeconds =>		
				if((sec_ones <= 0) and (sec_tens <= 0) and (mins <= 0)) then
					nextstate <= Finish;
				else
					nextstate <= SubSeconds;
				end if;
				sec_ones <= dec_sec_ones;
				sec_tens <= dec_sec_tens;
				mins <= dec_mins;
				inc_time_flag <= '0';
				dec_time_flag <= '1';
				led_flag <= '0';
			when Finish =>
				nextstate <= Finish;
				inc_time_flag <= '0';
				dec_time_flag <= '0';
				led_flag <= '1';
		end case;
	end process;
	
	-- Next Enable Logic
	process(clk_1ms, en, Reset, state) begin
	if(Reset = '0') then
		Enable <= "111";
		SevenSD <= "00000000";
		en <= NoDigit;
	elsif(rising_edge(clk_1ms)) then
		case(en) is
			when NoDigit =>
				Enable <= "111";
				en <= Digit1;
				SevenSD <= "00000000";
			when Digit1 => 
				SevenSD <= Display_Mins;
				Enable <= "011";
				en <= Digit2;
			when Digit2 => 
				SevenSD <= Display_Tens;
				Enable <= "101";
				en <= Digit3;
			when Digit3 => 
				SevenSD <= Display_Ones;
				Enable <= "110";
				en <= Digit1;
		end case;
	end if;
	end process;
	                                   ----------------------------------------
	
	-- Outputs
	LED <= lights(15 downto 8);
		
end Structural;



