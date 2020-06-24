library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE . numeric_std . all;
use ieee.math_real.all;


entity sampling is
  generic (
		BRAM_ADDR_WIDTH   : positive := 16;
		NUM_BANDS          : positive := 16;
		NUM_VALUES       : positive := 65536;
		BRAM_DATA_WIDTH    : positive := 32;
		m                 : positive := 128;
		BRAM_ADDR_WIDTH_A : positive :=  7--;integer(ceil(log2(real(m))))
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
end sampling;


architecture rtl of sampling is

  component lfsr1 is
    generic (
  		BRAM_ADDR_WIDTH   : positive := 16
  	);
    port (
      CLK           : in std_logic;
      RESETN        : in std_logic;
      count         : out std_logic_vector(BRAM_ADDR_WIDTH - 1 downto 0); -- 16 bits
      count_unsigned : out unsigned(BRAM_ADDR_WIDTH - 1 downto 0) -- 16 bits
    );
  end component;

  component BRAM_r is
    generic (
      SIZE       : integer := 16; --m;
      ADDR_WIDTH : integer := 4; --integer(ceil(log2(real(NUM_VALUES))));  -- 7
      COL_WIDTH  : integer := 32;
      NB_COL     : integer := 16);
    port (
      clk    : in std_logic;
      reset_n : in std_logic;
      we     : in std_logic_vector(NB_COL - 1 downto 0);
      r_addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      w_addr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      din    : in std_logic_vector(COL_WIDTH - 1 downto 0);
      dout   : out std_logic_vector (NB_COL * COL_WIDTH - 1 downto 0)
    );
  end component;

  component GraphA is
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
  end component;

  component Reg32 is
    PORT(
        d   : IN STD_LOGIC_VECTOR(BRAM_DATA_WIDTH - 1 DOWNTO 0);
        ld  : IN STD_LOGIC; -- load/enable.
        clr : IN STD_LOGIC; -- async. clear.
        CLK : IN STD_LOGIC; -- clock.
        q   : OUT STD_LOGIC_VECTOR(BRAM_DATA_WIDTH - 1 DOWNTO 0) -- output
    );
  end component;

--  component Reg3 is
--    PORT(
--        d   : IN STD_LOGIC_VECTOR(BRAM_ADDR_WIDTH - 1 DOWNTO 0);
--        ld  : IN STD_LOGIC; -- load/enable.
--        clr : IN STD_LOGIC; -- async. clear.
--        CLK : IN STD_LOGIC; -- clock.
--        q   : OUT STD_LOGIC_VECTOR(BRAM_ADDR_WIDTH - 1 DOWNTO 0) -- output
--    );

--end component;
  type state_type is (Idle, Fetch, Fetch_Wait, Decode_BRAM, Execute, Save);
  signal state : state_type := Idle;

  signal count : std_logic_vector(BRAM_ADDR_WIDTH - 1 downto 0); -- 16 bits
  signal rand_unsigned : unsigned(BRAM_ADDR_WIDTH - 1 downto 0); -- 16 bits

  --signal d : STD_LOGIC_VECTOR(BRAM_DATA_WIDTH - 1 DOWNTO 0);
  signal ld : std_logic;
  signal clr : std_logic;
  signal q :  STD_LOGIC_VECTOR(BRAM_DATA_WIDTH - 1 DOWNTO 0);


  signal ld_2 : std_logic;
  signal clr_2 : std_logic;
  signal q_2 :  STD_LOGIC_VECTOR(BRAM_ADDR_WIDTH - 1 DOWNTO 0);

  signal r_addr : STD_LOGIC_VECTOR(integer(ceil(log2(real(m)))) - 1 DOWNTO 0);
  signal w_addr : std_logic_vector(integer(ceil(log2(real(m)))) - 1 downto 0);
  signal we     : std_logic_vector(1 - 1 downto 0);

  signal GraphA_en : std_logic;
  signal GraphA_done : std_logic := '0';

signal p : std_logic_vector (BRAM_DATA_WIDTH - 1 downto 0) ;

 begin
  lfsr1_inst : lfsr1
  generic map
	(
  BRAM_ADDR_WIDTH => BRAM_ADDR_WIDTH
  )
  port map
  (
  CLK          => CLK ,
  RESETN       => RESETN,
  count        => count,
  count_unsigned => rand_unsigned
  );

  BRAM_STATIC_init : BRAM_r
	generic map(
		SIZE       => m,
		ADDR_WIDTH => BRAM_ADDR_WIDTH_A,  -- 7
		COL_WIDTH  => BRAM_ADDR_WIDTH,
			NB_COL     => 1
	)
	port map(
		clk    => CLK,
		reset_n => RESETN,
		we     => we,
		r_addr => r_addr,
		w_addr => w_addr,
		din    => count,
		dout   => ROW_SELECT
	);

  Reg32_inst : Reg32
    port map (
    d   => X_i,
    ld  => ld,
    clr => clr,
    CLK => CLK,
    q   => q
    );

  GraphA_inst : GraphA
    port map(
    CLK => CLK,
    RESETN => RESETN,
    X_i => X_i,
    X_i_2 => q,
    --p => A_i
    p => p
  );


  A_i <= X_i;

--ROW_SELECT <= count_temp;

 -- process(RESETN, CLK)
 -- variable i : integer := 0;
 -- variable counter : integer := 0;
 -- begin
  --    if (RESETN = '0') then
   --     ld  <= '0';
    --    i := 0;
     --   counter := 0;
    --   clr <= '1';
 --      count_temp <= (others => '0' );
 --     elsif (rising_edge(CLK) and  (i < m) ) then
  --      clr <= '0';
   --     counter := counter + 1;
   --     if (counter > 3) then -- counter for subtract and shift
    --        ROW_SELECT <= count_temp;
     --       counter := 0;
  --      end if;
   ---     if(i = 0 or i = 1 or i = 2 ) THEN -- load and fix the first sampled element
    --      ld <= '1';
     --   else
      --    ld <= '0';
       -- end if;
     -- end if;
     -- i := i + 1;

  -- end process;


--ROW_SELECT <= q_2;

--- process with BRAM to save random addresses

process(RESETN, CLK)
variable i : integer := 0;
variable counter : integer := 0;
begin
    if (RESETN = '0') then
      GraphA_en <= '0';
      counter := 0;
      we <= (others     => '0'); --- do not write
    elsif (rising_edge(CLK) ) then
      if (counter < m) then
        we <= (others  => '1');
        w_addr <= std_logic_vector(to_unsigned(counter, w_addr'length));
        counter := counter + 1;
      else
        we <= (others     => '0');
        GraphA_en <= '1';
      end if;
    end if;
end process;


-- process for GraphA

process(RESETN, CLK)
variable i : integer := 0;
variable j : integer := 0;
variable counter : integer := 0;
variable A_counter : integer := 0;
begin
    if (RESETN = '0') then
      ld  <= '0';
      i := 0;
      j := 0;
      A_counter := 0;
      A_we <= (others     => '0');
      A_w_addr <= (others     => '0');
      counter := 0;
      clr <= '1';
      --ROW_SELECT <= (others => '0' );
    elsif (rising_edge(CLK) ) then
      case state is
        when Idle =>
            A_we <= (others     => '0');
            if (GraphA_done = '1') then
                state <= Idle;
            elsif (GraphA_en = '1' and HyperCube_Ready = '1') then
              clr <= '0';
              state   <= Fetch;
            else state <= Idle;
          end if;

        when Fetch => -- read first address
             -- A_we <= (others     => '0');
              if (j=0 and i < m) then -- read i when its a new round
              r_addr <= std_logic_vector(to_unsigned(i, r_addr'length));
              i := i + 1;
              end if;
              --clr <= '0';

              state <= Fetch_Wait;
        when Fetch_Wait =>  -- first bram is already read, read second address, and save the first read element into a register
              if (j=0) then -- load when its a new round
                ld  <= '1';
              end if;
              A_we <= (others     => '0');
              r_addr <= std_logic_vector(to_unsigned(j, r_addr'length));

              state <= Decode_BRAM;
        when Decode_BRAM =>  -- second bram is read
              ld <= '0';

              state <= Execute;
        when Execute =>
          if (counter < 3) then -- counter for subtract and shift
           counter := counter + 1;
           state <= Execute;
         else
           counter := 0;
           state <= Save;
         end if;

        when Save => -- save in bram
          A_w_addr <= std_logic_vector(to_unsigned(A_counter, A_w_addr'length));
          A_we <= (others     => '1');
          A_counter := A_counter + 1;
          if (j < m) then
            j := j + 1;
            state <= Fetch;  -- next fetch.
          else
              j := 0;
              if (i < m ) then
                --i := i + 1;
                state <= Fetch;  -- next fetch.
              else
              --GraphA_en <= '0';
              GraphA_done <= '1';
              state <= Idle; -- done
              end if;
          end if;


        when others =>
            state <= Idle;

      end case;
  end if;
end process;





--  process(RESETN, CLK)
--  variable i : integer := 0;
--  variable counter : integer := 0;
--  begin
--      if (RESETN = '0') then
--        ld  <= '0';
--        ld_2 <= '0';
--        i := 0;
--        counter := 0;
--        clr <= '1';
--        clr_2 <= '1';
--        ROW_SELECT <= (others => '0' );
--      elsif (rising_edge(CLK) and GraphA_en = '1' ) then
--        clr <= '0';
--        clr_2 <= '0';

--        if (counter < 3) then -- counter for subtract and shift
--            ld_2 <= '0';
--           counter := counter + 1;
--        else
--            ROW_SELECT <= count;
--            ld_2 <= '1';
--            counter := 0;
--        end if;
--        if(i < m*3 ) THEN -- load and register the first sampled element
--          ld <= '0';
--          i := i + 1;
--        else
--          ld <= '1';
--          i := 0;
--        end if;

--      end if;



--  end process;

end architecture;
