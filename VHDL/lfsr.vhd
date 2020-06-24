library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.math_real.all;
use IEEE.numeric_std.all;


entity lfsr1 is
  generic (
		BRAM_ADDR_WIDTH   : positive := 16
	);

  port (
    CLK           : in std_logic;
    RESETN        : in std_logic;
    count       : out std_logic_vector(BRAM_ADDR_WIDTH-1 downto 0); -- 16 bits
    count_unsigned : out unsigned(BRAM_ADDR_WIDTH-1 downto 0) -- 16 bits
  );
end lfsr1;

architecture rtl of lfsr1 is

  signal count_i  : std_logic_vector(BRAM_ADDR_WIDTH-1 downto 0);
  signal feedback : std_logic;

begin
  feedback <= not(count_i(BRAM_ADDR_WIDTH-1) xor count_i(BRAM_ADDR_WIDTH-2));

  process(RESETN, CLK)
  begin
      if (RESETN = '0') then
        count_i <= (others => '0' );
      elsif (rising_edge(CLK)) then
        count_i <= count_i(BRAM_ADDR_WIDTH-2 downto 0) & feedback;
      end if;


  end process;
  count <= count_i;
  count_unsigned <= unsigned(count_i);
end architecture;
