library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.ALL;
use std.textio.all;

entity sampling_tb is
end entity;

architecture test of sampling_tb is

component sampling is
	generic (
		BRAM_ADDR_WIDTH   : positive := 16;
		NUM_BANDS          : positive := 16;
		NUM_VALUES       : positive := 65536;
		BRAM_DATA_WIDTH    : positive := 32;
		m                 : positive := 128;
		BRAM_ADDR_WIDTH_A : positive :=  14--;integer(ceil(log2(real(m))))
	);

  port (
    CLK           : in std_logic;
    RESETN        : in std_logic;
    ROW_SELECT       : out std_logic_vector (BRAM_ADDR_WIDTH - 1 downto 0);
    --ROW_SELECT_RAND       : out std_logic_vector (BRAM_ADDR_WIDTH - 1 downto 0);
	X_i : in std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);
    --count         : out std_logic_vector(BRAM_ADDR_WIDTH - 1 downto 0); -- 16 bits
    A_i           : out std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);
    A_we         : out std_logic_vector (0 downto 0);
    A_w_addr         : out std_logic_vector(BRAM_ADDR_WIDTH_A - 1 downto 0);
    HyperCube_Ready : in std_logic
		);
	end component;


constant PERIOD : time := 20 ns;
constant BRAM_ADDR_WIDTH   : positive := 3;
constant NUM_BANDS          : positive := 16;
constant NUM_VALUES       : positive := 65536;
constant BRAM_DATA_WIDTH    : positive := 32;
constant m : integer := 8;
constant BRAM_ADDR_WIDTH_A : positive := 3;

signal CLK           : std_logic;
--signal en            : std_logic;
signal RESETN        : std_logic;
signal ROW_SELECT    : std_logic_vector (BRAM_ADDR_WIDTH - 1 downto 0); --out
signal X_i_temp         :  std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);

signal A_i            : std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0);
signal A_we         :  std_logic_vector (0 downto 0);
signal A_w_addr         :  std_logic_vector(BRAM_ADDR_WIDTH_A - 1 downto 0);
 signal  HyperCube_Ready :  std_logic;

type BRAM_Array is array (0 to 7) of std_logic_vector(BRAM_DATA_WIDTH-1 downto 0);
signal BRAM_Array_1 : BRAM_Array;


begin
  sampling_INST:  sampling
   generic map (
      BRAM_ADDR_WIDTH => BRAM_ADDR_WIDTH,
      NUM_BANDS => NUM_BANDS,
      NUM_VALUES  => NUM_VALUES,
      BRAM_DATA_WIDTH => BRAM_DATA_WIDTH,
      m         => m,
      BRAM_ADDR_WIDTH_A => BRAM_ADDR_WIDTH_A
      )
   port map (
      CLK     => CLK,
      RESETN      => RESETN,
      ROW_SELECT => ROW_SELECT,
      X_i    => X_i_temp ,
     A_i     => A_i,
    A_we    => A_we,
    A_w_addr       => A_w_addr,
    HyperCube_Ready => HyperCube_Ready);

  process is
  begin
    RESETN <= '0';
    wait for 50 NS;
    RESETN <= '1';
    wait;
  end process;

  process is
  begin
    CLK <= '0';
    wait for 10 NS;
    CLK <= '1';
    wait for 10 NS;
  end process;

--ROW_SELECT <= std_logic_vector(to_unsigned(ROW_SELECT_temp, ROW_SELECT'length)) when (RESETN = '0') else (others=>'Z');


  process (CLK) is
variable i : integer := 0;
variable counter : integer := 0;
variable counter_bram : integer := 0;
  begin
    if (RESETN = '0') then
      X_i_temp <= (others => '0');
      HyperCube_Ready <= '0';
      i := 0;
      BRAM_Array_1(0) <= std_logic_vector(to_unsigned(1, 32));
      BRAM_Array_1(1) <= std_logic_vector(to_unsigned(4, 32));
      BRAM_Array_1(2) <= std_logic_vector(to_unsigned(5, 32));
      BRAM_Array_1(3) <= std_logic_vector(to_unsigned(6, 32));
      BRAM_Array_1(4) <= std_logic_vector(to_unsigned(3, 32));
      BRAM_Array_1(5) <= std_logic_vector(to_unsigned(9, 32));
      BRAM_Array_1(6) <= std_logic_vector(to_unsigned(10, 32));
      BRAM_Array_1(7) <= std_logic_vector(to_unsigned(11, 32));
    elsif  (rising_edge(CLK)) then
     HyperCube_Ready <= '1';
     -- ROW_SELECT_temp <= to_integer(unsigned(ROW_SELECT));
     if (counter_bram > 2) then
         if (counter > 6) then
           if (i < 8) then
             X_i_temp <= BRAM_Array_1(i);
             i := i + 1;
             counter := 0;
            else i := 0; X_i_temp <= BRAM_Array_1(i);
           end if;
          else counter := counter + 1;
         end if;
        end if;
       else counter_bram := counter_bram +1;
    end if;
  end process;

end architecture;
