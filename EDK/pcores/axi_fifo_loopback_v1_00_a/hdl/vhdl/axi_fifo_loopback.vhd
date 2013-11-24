------------------------------------------------------------------------------
-- axi_fifo_loopback - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          axi_fifo_loopback
-- Version:           1.00.a
-- Description:       Example Axi Streaming core (VHDL).
-- Date:              Tue Nov 19 10:13:17 2013 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------
--
--
-- Definition of Ports
-- ACLK              : Synchronous clock
-- ARESETN           : System reset, active low
-- S_AXIS_TREADY  : Ready to accept data in
-- S_AXIS_TDATA   :  Data in 
-- S_AXIS_TLAST   : Optional data in qualifier
-- S_AXIS_TVALID  : Data in is valid
-- M_AXIS_TVALID  :  Data out is valid
-- M_AXIS_TDATA   : Data Out
-- M_AXIS_TLAST   : Optional data out qualifier
-- M_AXIS_TREADY  : Connected slave device is ready to accept data out
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Entity Section
------------------------------------------------------------------------------

entity axi_fifo_loopback is
	port 
	(
	  IN1 : in std_logic_vector(3 downto 0);
	  OUT1 : out std_logic_vector(3 downto 0);
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		ACLK	: in	std_logic;
		ARESETN	: in	std_logic;
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(31 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(31 downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end axi_fifo_loopback;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

architecture EXAMPLE of axi_fifo_loopback is

  COMPONENT fifo_generator_v9_3
    PORT (
      m_aclk        : IN STD_LOGIC;
      s_aclk        : IN STD_LOGIC;
      s_aresetn     : IN STD_LOGIC;
      s_axis_tvalid : IN STD_LOGIC;
      s_axis_tready : OUT STD_LOGIC;
      s_axis_tdata  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axis_tlast  : IN STD_LOGIC;
      m_axis_tvalid : OUT STD_LOGIC;
      m_axis_tready : IN STD_LOGIC;
      m_axis_tdata  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m_axis_tlast  : OUT STD_LOGIC
    );
  END COMPONENT;

   
   -- FIFO signals
   signal fifo_m_aclk         : STD_LOGIC;
   signal fifo_s_aclk         : STD_LOGIC;
   signal fifo_s_aresetn      : STD_LOGIC;
   signal fifo_s_axis_tvalid  : STD_LOGIC;
   signal fifo_s_axis_tready  : STD_LOGIC;
   signal fifo_s_axis_tdata   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   signal fifo_s_axis_tlast   : STD_LOGIC;
   signal fifo_m_axis_tvalid  : STD_LOGIC;
   signal fifo_m_axis_tready  : STD_LOGIC;
   signal fifo_m_axis_tdata   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   signal fifo_m_axis_tlast   : STD_LOGIC;
   
   
begin

  axi_fifo_32b_inst : fifo_generator_v9_3
    PORT MAP (
      m_aclk        => fifo_m_aclk,
      s_aclk        => fifo_s_aclk,
      s_aresetn     => fifo_s_aresetn,
      s_axis_tvalid => fifo_s_axis_tvalid,
      s_axis_tready => fifo_s_axis_tready,
      s_axis_tdata  => fifo_s_axis_tdata,
      s_axis_tlast  => fifo_s_axis_tlast,
      m_axis_tvalid => fifo_m_axis_tvalid,
      m_axis_tready => fifo_m_axis_tready,
      m_axis_tdata  => fifo_m_axis_tdata,
      m_axis_tlast  => fifo_m_axis_tlast
    );
    
    -- Master FIFO interface
    fifo_m_aclk         <= ACLK;
	  M_AXIS_TVALID       <= fifo_m_axis_tvalid;
    fifo_m_axis_tready  <= M_AXIS_TREADY;
	  M_AXIS_TDATA        <= fifo_m_axis_tdata;
	  M_AXIS_TLAST        <= fifo_m_axis_tlast;
    
    -- Slave FIFO interface to AXI bus master interface
    fifo_s_aclk         <= ACLK;
    fifo_s_aresetn      <= ARESETN;
    fifo_s_axis_tvalid  <= S_AXIS_TVALID;
	  S_AXIS_TREADY       <= fifo_s_axis_tready;
    fifo_s_axis_tdata   <= S_AXIS_TDATA;
    fifo_s_axis_tlast   <= S_AXIS_TLAST;
    
end architecture EXAMPLE;
