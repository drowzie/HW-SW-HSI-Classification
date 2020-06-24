-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\hasan_000\Desktop\NTNU\Thesis\BPT\codegen\call_exp\hdlsrc\call_exp_fixpt_tb.vhd
-- Created: 2020-06-19 20:13:08
-- 
-- Generated by MATLAB 9.6, MATLAB Coder 4.2 and HDL Coder 3.14
-- 
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1
-- Target subsystem base rate: 1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: call_exp_fixpt_tb
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
LIBRARY work;
USE work.call_exp_fixpt_pkg.ALL;
USE work.call_exp_fixpt_tb_pkg.ALL;

ENTITY call_exp_fixpt_tb IS
END call_exp_fixpt_tb;


ARCHITECTURE rtl OF call_exp_fixpt_tb IS

  -- Component Declarations
  COMPONENT call_exp_fixpt
    PORT( x                               :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14_En9
          y                               :   OUT   std_logic_vector(13 DOWNTO 0)  -- ufix14_En13
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : call_exp_fixpt
    USE ENTITY work.call_exp_fixpt(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL y_done                           : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL y_done_enb                       : std_logic;  -- ufix1
  SIGNAL y_addr                           : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL y_active                         : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL snkDonen                         : std_logic;
  SIGNAL resetn                           : std_logic;
  SIGNAL tb_enb                           : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL y_enb                            : std_logic;  -- ufix1
  SIGNAL y_lastAddr                       : std_logic;  -- ufix1
  SIGNAL x_addr                           : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL x_active                         : std_logic;  -- ufix1
  SIGNAL x_enb                            : std_logic;  -- ufix1
  SIGNAL x_addr_delay_1                   : unsigned(9 DOWNTO 0);  -- ufix10
  SIGNAL rawData_x                        : unsigned(13 DOWNTO 0);  -- ufix14_En9
  SIGNAL holdData_x                       : unsigned(13 DOWNTO 0);  -- ufix14_En9
  SIGNAL x_offset                         : unsigned(13 DOWNTO 0);  -- ufix14_En9
  SIGNAL x_1                              : unsigned(13 DOWNTO 0);  -- ufix14_En9
  SIGNAL x_2                              : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL y_1                              : std_logic_vector(13 DOWNTO 0);  -- ufix14
  SIGNAL y_unsigned                       : unsigned(13 DOWNTO 0);  -- ufix14_En13
  SIGNAL y_expected_1                     : unsigned(13 DOWNTO 0);  -- ufix14_En13
  SIGNAL y_ref                            : unsigned(13 DOWNTO 0);  -- ufix14_En13
  SIGNAL y_testFailure                    : std_logic;  -- ufix1

BEGIN
  u_call_exp_fixpt : call_exp_fixpt
    PORT MAP( x => x_2,  -- ufix14_En9
              y => y_1  -- ufix14_En13
              );

  y_done_enb <= y_done AND rdEnb;

  
  y_active <= '1' WHEN y_addr /= to_unsigned(16#3E7#, 10) ELSE
      '0';

  enb <= rdEnb AFTER 2 ns;

  snkDonen <=  NOT check1_done;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF check1_done = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  
  rdEnb <= tb_enb WHEN check1_done = '0' ELSE
      '0';

  ce_out <= enb AND (rdEnb AND tb_enb);

  y_enb <= ce_out AND y_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 999
  y_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_addr <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF y_enb = '1' THEN
        IF y_addr >= to_unsigned(16#3E7#, 10) THEN 
          y_addr <= to_unsigned(16#000#, 10);
        ELSE 
          y_addr <= y_addr + to_unsigned(16#001#, 10);
        END IF;
      END IF;
    END IF;
  END PROCESS y_process;


  
  y_lastAddr <= '1' WHEN y_addr >= to_unsigned(16#3E7#, 10) ELSE
      '0';

  y_done <= y_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF y_done_enb = '1' THEN
        check1_done <= y_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  
  x_active <= '1' WHEN x_addr /= to_unsigned(16#3E7#, 10) ELSE
      '0';

  x_enb <= x_active AND (rdEnb AND tb_enb);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 999
  x_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_addr <= to_unsigned(16#000#, 10);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF x_enb = '1' THEN
        IF x_addr >= to_unsigned(16#3E7#, 10) THEN 
          x_addr <= to_unsigned(16#000#, 10);
        ELSE 
          x_addr <= x_addr + to_unsigned(16#001#, 10);
        END IF;
      END IF;
    END IF;
  END PROCESS x_process;


  x_addr_delay_1 <= x_addr AFTER 1 ns;

  -- Data source for x
  x_fileread: PROCESS (x_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "x.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(15 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_x <= unsigned(read_data(13 DOWNTO 0));
  END PROCESS x_fileread;

  -- holdData reg for x
  stimuli_x_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_x <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_x <= rawData_x;
    END IF;
  END PROCESS stimuli_x_process;

  stimuli_x_1: PROCESS (rawData_x, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      x_offset <= holdData_x;
    ELSE
      x_offset <= rawData_x;
    END IF;
  END PROCESS stimuli_x_1;

  x_1 <= x_offset AFTER 2 ns;

  x_2 <= std_logic_vector(x_1);

  y_unsigned <= unsigned(y_1);

  -- Data source for y_expected
  y_expected_1 <= to_unsigned(16#0000#, 14);

  y_ref <= y_expected_1;

  y_unsigned_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF ce_out = '1' AND y_unsigned /= y_ref THEN
        y_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in y_unsigned: Expected " & to_hex(y_ref) & (" Actual " & to_hex(y_unsigned))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS y_unsigned_checker;

  completed_msg: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF check1_done = '1' THEN
        IF y_testFailure = '0' THEN
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (PASSED)**************"
            SEVERITY NOTE;
        ELSE
          ASSERT FALSE
            REPORT "**************TEST COMPLETED (FAILED)**************"
            SEVERITY NOTE;
        END IF;
      END IF;
    END IF;
  END PROCESS completed_msg;

END rtl;

