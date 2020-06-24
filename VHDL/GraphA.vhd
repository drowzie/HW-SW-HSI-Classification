library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity GraphA is
  generic (
    BRAM_DATA_WIDTH   : positive := 32;
    NUM_VALUES       : positive := 65536
    );
  port (
    CLK           : in std_logic;
    RESETN        : in std_logic;
    X_i : in std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);
    X_i_2 : in std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);
    p           : out std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0)
  );
end GraphA;

architecture Behavioral of GraphA is

	component dp_datapath is
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
	end component;

begin
    dp_datapath_inst : dp_datapath
		generic map(
			bit_depth_1 => BRAM_DATA_WIDTH,
			bit_depth_2 => BRAM_DATA_WIDTH,
			SHIFT_BITS => 1
		)
		port map(
			clk     => CLK,
			en      => '1',
			reset_n => RESETN,
			in_1    => X_i,
			in_2    => X_i_2,
			p       => p
		);

  end architecture;
