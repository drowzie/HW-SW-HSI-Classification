library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity tb_lfsr1 is
end entity;

architecture test of tb_lfsr1 is

constant PERIOD : time := 20 ns;

signal CLK : std_logic := '0';
signal RESETN : std_logic := '1';
signal count : std_logic_vector (16 downto 0);
signal count_unsigned : unsigned(16 downto 0); -- 16 bits
signal endSim : boolean := false;

component lfsr1 is
port (
RESETN : in std_logic;
CLK : in std_logic;
count : out std_logic_vector (16 downto 0);
count_unsigned : out unsigned(16 downto 0) -- 16 bits
);
end component;

begin
CLK <= not CLK after PERIOD/2;
RESETN <= '0' after PERIOD*10;
endSim <= true after PERIOD*8000;

-- End the simulation
process
begin
  if (endSim) then
    assert false
    report "End of simulation."
    severity failure;
  end if;
  wait until (CLK = '1');
end process;

lfrs1_inst : lfsr1
port map (
    CLK => CLK,
    RESETN => RESETN,
    count => count,
    count_unsigned => count_unsigned
);
end architecture;
