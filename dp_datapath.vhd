----------------------------------------------------------------------------------
-- Company:
-- Engineer: Mohamed Ismail
--
-- Create Date:
-- Design Name:
-- Module Name: A_i datapath
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: MAC unit
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE . STD_LOGIC_1164 . all;
use IEEE . numeric_std . all;

entity dp_datapath is
	generic (
		bit_depth_1 : positive := 32;
		bit_depth_2 : positive := 32;
		SHIFT_BITS  : positive := 1
	);
	port (
		clk     : in std_logic;
		en      : in std_logic;
		reset_n : in std_logic;
		in_1    : in std_logic_vector (bit_depth_1 - 1 downto 0);
		in_2    : in std_logic_vector (bit_depth_2 - 1 downto 0);
		p       : out std_logic_vector (bit_depth_1 - 1 downto 0)
	);
end dp_datapath;

architecture Behavioral of dp_datapath is

 component   call_exp_fixpt IS
  port ( x                                 :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14_En9
        y                                 :   OUT   std_logic_vector(13 DOWNTO 0)  -- ufix14_En13
        );
    end component;

	--signal mul_r 	: std_logic_vector ((bit_depth_1 + bit_depth_2 - 1) downto 0);
	signal add_r 	: std_logic_vector ((bit_depth_1 - 1) downto 0);
	signal in_1_reg	: std_logic_vector (bit_depth_1 - 1 downto 0);
	signal in_2_reg	: std_logic_vector (bit_depth_2 - 1 downto 0);
	signal temp: std_logic_vector (bit_depth_1 - 1 downto 0);
	signal x: std_logic_vector(13 DOWNTO 0);
	signal y: std_logic_vector(13 DOWNTO 0);

begin

    call_exp_fixpt_inst : call_exp_fixpt
		port map(
			x     => x,
			y      => y
			);

    x <= std_logic_vector(resize(signed(add_r),14));
	p <= std_logic_vector(resize(signed(y), p'length));

	process (clk, reset_n)
	begin
			if (reset_n = '0') then

				temp 		<= (others => '0');
				add_r 		<= (others => '0');
				in_1_reg	<= (others => '0');
				in_2_reg	<= (others => '0');
				--p           <= (others => '0');

			elsif (rising_edge (clk) and en = '1') then

				--First pipeline stage regs
				in_1_reg <= in_1;
				in_2_reg <= in_2;
				--p <= std_logic_vector(to_unsigned(1, 32));

				-- Multiply in1 and in2
				--mul_r <= std_logic_vector (resize(((signed (in_1_reg) - signed (in_2_reg)) * to_signed(CONSTANT_U, in_1_reg'length)),in_1_reg'length) * to_signed(1_OVER_BASE2, in_1_reg'length));
				temp <= std_logic_vector(signed (in_1_reg) - signed (in_2_reg)); --/(-2*CONSTANT_U);
				--mul_r <= std_logic_vector ( to_signed((to_integer(signed (in_1_reg) - signed (in_2_reg)))/2 , mul_r'LENGTH  ));

				if temp(bit_depth_1-1) = '1' and temp(0) = '1' then -- odd negative numbers

                add_r <= std_logic_vector(SHIFT_RIGHT(signed(temp)+1, SHIFT_BITS));
                --p <= std_logic_vector(SHIFT_RIGHT(signed(temp)+1, SHIFT_BITS));
                 else
                add_r <= std_logic_vector(SHIFT_RIGHT(signed(temp), SHIFT_BITS));
                --p <= std_logic_vector(SHIFT_RIGHT(signed(temp), SHIFT_BITS));
                 end if;

			end if;

	end process;
end Behavioral;
