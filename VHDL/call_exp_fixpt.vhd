-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\hasan_000\Desktop\NTNU\Thesis\BPT\codegen\call_exp\hdlsrc\call_exp_fixpt.vhd
-- Created: 2020-06-19 20:10:56
-- 
-- Generated by MATLAB 9.6, MATLAB Coder 4.2 and HDL Coder 3.14
-- 
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Design base rate: 1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: call_exp_fixpt
-- Source Path: call_exp_fixpt
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.call_exp_fixpt_pkg.ALL;

ENTITY call_exp_fixpt IS
  port ( x                              :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14_En9
        y                                 :   OUT   std_logic_vector(13 DOWNTO 0)  -- ufix14_En13
        );
END call_exp_fixpt;


ARCHITECTURE rtl OF call_exp_fixpt IS

  -- Constants
  CONSTANT nc                             : vector_of_unsigned14(0 TO 999) := 
    (to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14),
     to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0000#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14), to_unsigned(16#0001#, 14),
     to_unsigned(16#0001#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14),
     to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14),
     to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14),
     to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14),
     to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14), to_unsigned(16#0002#, 14),
     to_unsigned(16#0002#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14),
     to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14),
     to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14),
     to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14), to_unsigned(16#0003#, 14),
     to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14),
     to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14),
     to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0004#, 14), to_unsigned(16#0005#, 14),
     to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14),
     to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14), to_unsigned(16#0005#, 14),
     to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14),
     to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14), to_unsigned(16#0006#, 14),
     to_unsigned(16#0007#, 14), to_unsigned(16#0007#, 14), to_unsigned(16#0007#, 14), to_unsigned(16#0007#, 14),
     to_unsigned(16#0007#, 14), to_unsigned(16#0007#, 14), to_unsigned(16#0008#, 14), to_unsigned(16#0008#, 14),
     to_unsigned(16#0008#, 14), to_unsigned(16#0008#, 14), to_unsigned(16#0008#, 14), to_unsigned(16#0008#, 14),
     to_unsigned(16#0009#, 14), to_unsigned(16#0009#, 14), to_unsigned(16#0009#, 14), to_unsigned(16#0009#, 14),
     to_unsigned(16#0009#, 14), to_unsigned(16#0009#, 14), to_unsigned(16#000A#, 14), to_unsigned(16#000A#, 14),
     to_unsigned(16#000A#, 14), to_unsigned(16#000A#, 14), to_unsigned(16#000B#, 14), to_unsigned(16#000B#, 14),
     to_unsigned(16#000B#, 14), to_unsigned(16#000B#, 14), to_unsigned(16#000B#, 14), to_unsigned(16#000C#, 14),
     to_unsigned(16#000C#, 14), to_unsigned(16#000C#, 14), to_unsigned(16#000C#, 14), to_unsigned(16#000D#, 14),
     to_unsigned(16#000D#, 14), to_unsigned(16#000D#, 14), to_unsigned(16#000E#, 14), to_unsigned(16#000E#, 14),
     to_unsigned(16#000E#, 14), to_unsigned(16#000E#, 14), to_unsigned(16#000F#, 14), to_unsigned(16#000F#, 14),
     to_unsigned(16#000F#, 14), to_unsigned(16#0010#, 14), to_unsigned(16#0010#, 14), to_unsigned(16#0010#, 14),
     to_unsigned(16#0011#, 14), to_unsigned(16#0011#, 14), to_unsigned(16#0011#, 14), to_unsigned(16#0012#, 14),
     to_unsigned(16#0012#, 14), to_unsigned(16#0012#, 14), to_unsigned(16#0013#, 14), to_unsigned(16#0013#, 14),
     to_unsigned(16#0014#, 14), to_unsigned(16#0014#, 14), to_unsigned(16#0014#, 14), to_unsigned(16#0015#, 14),
     to_unsigned(16#0015#, 14), to_unsigned(16#0016#, 14), to_unsigned(16#0016#, 14), to_unsigned(16#0017#, 14),
     to_unsigned(16#0017#, 14), to_unsigned(16#0018#, 14), to_unsigned(16#0018#, 14), to_unsigned(16#0019#, 14),
     to_unsigned(16#0019#, 14), to_unsigned(16#001A#, 14), to_unsigned(16#001A#, 14), to_unsigned(16#001B#, 14),
     to_unsigned(16#001B#, 14), to_unsigned(16#001C#, 14), to_unsigned(16#001C#, 14), to_unsigned(16#001D#, 14),
     to_unsigned(16#001D#, 14), to_unsigned(16#001E#, 14), to_unsigned(16#001F#, 14), to_unsigned(16#001F#, 14),
     to_unsigned(16#0020#, 14), to_unsigned(16#0021#, 14), to_unsigned(16#0021#, 14), to_unsigned(16#0022#, 14),
     to_unsigned(16#0023#, 14), to_unsigned(16#0023#, 14), to_unsigned(16#0024#, 14), to_unsigned(16#0025#, 14),
     to_unsigned(16#0026#, 14), to_unsigned(16#0026#, 14), to_unsigned(16#0027#, 14), to_unsigned(16#0028#, 14),
     to_unsigned(16#0029#, 14), to_unsigned(16#002A#, 14), to_unsigned(16#002B#, 14), to_unsigned(16#002B#, 14),
     to_unsigned(16#002C#, 14), to_unsigned(16#002D#, 14), to_unsigned(16#002E#, 14), to_unsigned(16#002F#, 14),
     to_unsigned(16#0030#, 14), to_unsigned(16#0031#, 14), to_unsigned(16#0032#, 14), to_unsigned(16#0033#, 14),
     to_unsigned(16#0034#, 14), to_unsigned(16#0035#, 14), to_unsigned(16#0036#, 14), to_unsigned(16#0037#, 14),
     to_unsigned(16#0038#, 14), to_unsigned(16#003A#, 14), to_unsigned(16#003B#, 14), to_unsigned(16#003C#, 14),
     to_unsigned(16#003D#, 14), to_unsigned(16#003E#, 14), to_unsigned(16#0040#, 14), to_unsigned(16#0041#, 14),
     to_unsigned(16#0042#, 14), to_unsigned(16#0044#, 14), to_unsigned(16#0045#, 14), to_unsigned(16#0046#, 14),
     to_unsigned(16#0048#, 14), to_unsigned(16#0049#, 14), to_unsigned(16#004B#, 14), to_unsigned(16#004C#, 14),
     to_unsigned(16#004E#, 14), to_unsigned(16#004F#, 14), to_unsigned(16#0051#, 14), to_unsigned(16#0053#, 14),
     to_unsigned(16#0054#, 14), to_unsigned(16#0056#, 14), to_unsigned(16#0058#, 14), to_unsigned(16#005A#, 14),
     to_unsigned(16#005C#, 14), to_unsigned(16#005D#, 14), to_unsigned(16#005F#, 14), to_unsigned(16#0061#, 14),
     to_unsigned(16#0063#, 14), to_unsigned(16#0065#, 14), to_unsigned(16#0067#, 14), to_unsigned(16#0069#, 14),
     to_unsigned(16#006C#, 14), to_unsigned(16#006E#, 14), to_unsigned(16#0070#, 14), to_unsigned(16#0072#, 14),
     to_unsigned(16#0075#, 14), to_unsigned(16#0077#, 14), to_unsigned(16#0079#, 14), to_unsigned(16#007C#, 14),
     to_unsigned(16#007E#, 14), to_unsigned(16#0081#, 14), to_unsigned(16#0083#, 14), to_unsigned(16#0086#, 14),
     to_unsigned(16#0089#, 14), to_unsigned(16#008C#, 14), to_unsigned(16#008E#, 14), to_unsigned(16#0091#, 14),
     to_unsigned(16#0094#, 14), to_unsigned(16#0097#, 14), to_unsigned(16#009A#, 14), to_unsigned(16#009E#, 14),
     to_unsigned(16#00A1#, 14), to_unsigned(16#00A4#, 14), to_unsigned(16#00A7#, 14), to_unsigned(16#00AB#, 14),
     to_unsigned(16#00AE#, 14), to_unsigned(16#00B2#, 14), to_unsigned(16#00B5#, 14), to_unsigned(16#00B9#, 14),
     to_unsigned(16#00BD#, 14), to_unsigned(16#00C1#, 14), to_unsigned(16#00C4#, 14), to_unsigned(16#00C8#, 14),
     to_unsigned(16#00CC#, 14), to_unsigned(16#00D1#, 14), to_unsigned(16#00D5#, 14), to_unsigned(16#00D9#, 14),
     to_unsigned(16#00DE#, 14), to_unsigned(16#00E2#, 14), to_unsigned(16#00E7#, 14), to_unsigned(16#00EB#, 14),
     to_unsigned(16#00F0#, 14), to_unsigned(16#00F5#, 14), to_unsigned(16#00FA#, 14), to_unsigned(16#00FF#, 14),
     to_unsigned(16#0104#, 14), to_unsigned(16#0109#, 14), to_unsigned(16#010F#, 14), to_unsigned(16#0114#, 14),
     to_unsigned(16#011A#, 14), to_unsigned(16#0120#, 14), to_unsigned(16#0125#, 14), to_unsigned(16#012B#, 14),
     to_unsigned(16#0131#, 14), to_unsigned(16#0138#, 14), to_unsigned(16#013E#, 14), to_unsigned(16#0144#, 14),
     to_unsigned(16#014B#, 14), to_unsigned(16#0152#, 14), to_unsigned(16#0158#, 14), to_unsigned(16#015F#, 14),
     to_unsigned(16#0167#, 14), to_unsigned(16#016E#, 14), to_unsigned(16#0175#, 14), to_unsigned(16#017D#, 14),
     to_unsigned(16#0184#, 14), to_unsigned(16#018C#, 14), to_unsigned(16#0194#, 14), to_unsigned(16#019D#, 14),
     to_unsigned(16#01A5#, 14), to_unsigned(16#01AD#, 14), to_unsigned(16#01B6#, 14), to_unsigned(16#01BF#, 14),
     to_unsigned(16#01C8#, 14), to_unsigned(16#01D1#, 14), to_unsigned(16#01DB#, 14), to_unsigned(16#01E4#, 14),
     to_unsigned(16#01EE#, 14), to_unsigned(16#01F8#, 14), to_unsigned(16#0202#, 14), to_unsigned(16#020D#, 14),
     to_unsigned(16#0217#, 14), to_unsigned(16#0222#, 14), to_unsigned(16#022D#, 14), to_unsigned(16#0239#, 14),
     to_unsigned(16#0244#, 14), to_unsigned(16#0250#, 14), to_unsigned(16#025C#, 14), to_unsigned(16#0268#, 14),
     to_unsigned(16#0274#, 14), to_unsigned(16#0281#, 14), to_unsigned(16#028E#, 14), to_unsigned(16#029B#, 14),
     to_unsigned(16#02A9#, 14), to_unsigned(16#02B7#, 14), to_unsigned(16#02C5#, 14), to_unsigned(16#02D3#, 14),
     to_unsigned(16#02E2#, 14), to_unsigned(16#02F1#, 14), to_unsigned(16#0300#, 14), to_unsigned(16#030F#, 14),
     to_unsigned(16#031F#, 14), to_unsigned(16#032F#, 14), to_unsigned(16#0340#, 14), to_unsigned(16#0351#, 14),
     to_unsigned(16#0362#, 14), to_unsigned(16#0373#, 14), to_unsigned(16#0385#, 14), to_unsigned(16#0397#, 14),
     to_unsigned(16#03AA#, 14), to_unsigned(16#03BD#, 14), to_unsigned(16#03D0#, 14), to_unsigned(16#03E4#, 14),
     to_unsigned(16#03F8#, 14), to_unsigned(16#040D#, 14), to_unsigned(16#0422#, 14), to_unsigned(16#0437#, 14),
     to_unsigned(16#044D#, 14), to_unsigned(16#0463#, 14), to_unsigned(16#047A#, 14), to_unsigned(16#0491#, 14),
     to_unsigned(16#04A9#, 14), to_unsigned(16#04C1#, 14), to_unsigned(16#04DA#, 14), to_unsigned(16#04F3#, 14),
     to_unsigned(16#050C#, 14), to_unsigned(16#0527#, 14), to_unsigned(16#0541#, 14), to_unsigned(16#055D#, 14),
     to_unsigned(16#0578#, 14), to_unsigned(16#0595#, 14), to_unsigned(16#05B2#, 14), to_unsigned(16#05CF#, 14),
     to_unsigned(16#05ED#, 14), to_unsigned(16#060C#, 14), to_unsigned(16#062B#, 14), to_unsigned(16#064B#, 14),
     to_unsigned(16#066C#, 14), to_unsigned(16#068D#, 14), to_unsigned(16#06AF#, 14), to_unsigned(16#06D1#, 14),
     to_unsigned(16#06F5#, 14), to_unsigned(16#0719#, 14), to_unsigned(16#073D#, 14), to_unsigned(16#0763#, 14),
     to_unsigned(16#0789#, 14), to_unsigned(16#07B0#, 14), to_unsigned(16#07D8#, 14), to_unsigned(16#0801#, 14),
     to_unsigned(16#082A#, 14), to_unsigned(16#0854#, 14), to_unsigned(16#087F#, 14), to_unsigned(16#08AB#, 14),
     to_unsigned(16#08D8#, 14), to_unsigned(16#0906#, 14), to_unsigned(16#0935#, 14), to_unsigned(16#0965#, 14),
     to_unsigned(16#0995#, 14), to_unsigned(16#09C7#, 14), to_unsigned(16#09F9#, 14), to_unsigned(16#0A2D#, 14),
     to_unsigned(16#0A62#, 14), to_unsigned(16#0A98#, 14), to_unsigned(16#0ACE#, 14), to_unsigned(16#0B06#, 14),
     to_unsigned(16#0B3F#, 14), to_unsigned(16#0B7A#, 14), to_unsigned(16#0BB5#, 14), to_unsigned(16#0BF2#, 14),
     to_unsigned(16#0C30#, 14), to_unsigned(16#0C6F#, 14), to_unsigned(16#0CAF#, 14), to_unsigned(16#0CF1#, 14),
     to_unsigned(16#0D34#, 14), to_unsigned(16#0D78#, 14), to_unsigned(16#0DBE#, 14), to_unsigned(16#0E05#, 14),
     to_unsigned(16#0E4D#, 14), to_unsigned(16#0E98#, 14), to_unsigned(16#0EE3#, 14), to_unsigned(16#0F30#, 14),
     to_unsigned(16#0F7F#, 14), to_unsigned(16#0FCF#, 14), to_unsigned(16#1021#, 14), to_unsigned(16#1074#, 14),
     to_unsigned(16#10CA#, 14), to_unsigned(16#1120#, 14), to_unsigned(16#1179#, 14), to_unsigned(16#11D4#, 14),
     to_unsigned(16#1230#, 14), to_unsigned(16#128E#, 14), to_unsigned(16#12EE#, 14), to_unsigned(16#1350#, 14),
     to_unsigned(16#13B4#, 14), to_unsigned(16#141A#, 14), to_unsigned(16#1482#, 14), to_unsigned(16#14EC#, 14),
     to_unsigned(16#1559#, 14), to_unsigned(16#15C7#, 14), to_unsigned(16#1638#, 14), to_unsigned(16#16AB#, 14),
     to_unsigned(16#1720#, 14), to_unsigned(16#1798#, 14), to_unsigned(16#1812#, 14), to_unsigned(16#188F#, 14),
     to_unsigned(16#190E#, 14), to_unsigned(16#1990#, 14), to_unsigned(16#1A14#, 14), to_unsigned(16#1A9B#, 14),
     to_unsigned(16#1B25#, 14), to_unsigned(16#1BB1#, 14), to_unsigned(16#1C41#, 14), to_unsigned(16#1CD3#, 14),
     to_unsigned(16#1D68#, 14), to_unsigned(16#1E00#, 14), to_unsigned(16#1E9C#, 14), to_unsigned(16#1F3A#, 14),
     to_unsigned(16#1FDC#, 14), to_unsigned(16#2081#, 14), to_unsigned(16#2129#, 14), to_unsigned(16#21D5#, 14),
     to_unsigned(16#2284#, 14), to_unsigned(16#2337#, 14), to_unsigned(16#23ED#, 14), to_unsigned(16#24A7#, 14),
     to_unsigned(16#2565#, 14), to_unsigned(16#2626#, 14), to_unsigned(16#26EC#, 14), to_unsigned(16#27B5#, 14),
     to_unsigned(16#2883#, 14), to_unsigned(16#2954#, 14), to_unsigned(16#2A2A#, 14), to_unsigned(16#2B05#, 14));  -- ufix14 [1000]

  -- Signals
  SIGNAL x_unsigned                       : unsigned(13 DOWNTO 0);  -- ufix14_En9
  SIGNAL y_tmp                            : unsigned(13 DOWNTO 0);  -- ufix14_En13

BEGIN
  x_unsigned <= unsigned(x);

  call_exp_fixpt_1_output : PROCESS 
  BEGIN
    --HDL code generation from MATLAB function: call_exp_fixpt
    --%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    --                                                                          %
    --           Generated by MATLAB 9.6 and Fixed-Point Designer 6.3           %
    --                                                                          %
    --%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    --
    -- Copyright 2020 The MathWorks, Inc.
    -- calculate replacement_exp via lookup table between extents x = fi([-10,10]),
    -- interpolation degree  = 1, number of points = 1000
    y_tmp <= to_unsigned(16#0000#, 14);
    WAIT;
  END PROCESS call_exp_fixpt_1_output;


  y <= std_logic_vector(y_tmp);

END rtl;

