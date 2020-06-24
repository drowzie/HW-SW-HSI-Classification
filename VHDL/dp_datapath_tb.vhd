library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity dp_datapath_tb is
end entity;

architecture test of dp_datapath_tb is

constant PERIOD : time := 20 ns;
constant bit_depth_1 : integer := 32;
constant bit_depth_2 : integer := 32;
constant SHIFT_BITS  : positive := 1;

signal clk           : std_logic;
signal en            : std_logic;
signal reset_n        : std_logic;

signal in_1          : std_logic_vector (bit_depth_1 - 1 downto 0);
signal in_2          : std_logic_vector (bit_depth_2 - 1 downto 0);
--signal p_rdy         : std_logic;
signal p             : std_logic_vector (bit_depth_1 - 1 downto 0);
--signal cnt           : integer;

begin
  dp_datapath_INST: entity work.dp_datapath
   generic map (
      bit_depth_1 => bit_depth_1,
      bit_depth_2 => bit_depth_2,
      SHIFT_BITS  => SHIFT_BITS
      )
   port map (
      clk     => clk,
      en      => en,
      reset_n => reset_n,
      in_1    => in_1,
      in_2    => in_2,
      p       => p);

  process is
  begin
    reset_n <= '0';
    wait for 50 NS;
    reset_n <= '1';
    wait;
  end process;

  process is
  begin
    clk <= '0';
    wait for 10 NS;
    clk <= '1';
    wait for 10 NS;
  end process;

  process (CLK) is

  begin
    if (rising_edge(CLK)) then
      if (reset_n = '0') then
        en  <= '0';
      else
        en  <= '1';
      end if;
    end if;
  end process;

  process is
  begin
    wait until CLK'event and CLK = '1';
    if (reset_n = '0') then
      in_1 <= std_logic_vector(to_unsigned(3, 32));
    elsif (en = '1') then
      in_1 <= std_logic_vector(unsigned(in_1) + 1);
    end if;

  end process;

  process is
  begin
    in_2 <= std_logic_vector(to_unsigned(1, bit_depth_2));
    -- wait for 5000 NS;
    -- in_G <=(others=>'1');
    -- wait for 1000 NS;
    -- in_G <=(others=>'0');
    wait;
  end process;



end architecture;
