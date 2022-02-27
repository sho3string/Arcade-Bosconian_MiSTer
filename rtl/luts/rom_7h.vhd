----------------------------------------------------------------------------------
--
-- Description:
-- async. timing PROM implementation
--
-- by Nolan Nicholson, 2021
-- This is a derivative work of the color PROMs for FPGA Galaga,
-- (c) copyright 2011...2015 by WoS (Wolfgang Scherr)
-- http://www.pin4.at - WoS <at> pin4 <dot> at
--
-- All Rights Reserved
--
-- Version 1.0
-- SVN: $Id$
--
-------------------------------------------------------------------------------
-- Redistribution and use in source or synthesized forms are permitted
-- provided that the following conditions are met (or a prior written
-- permission was given otherwise):
--
-- * Redistributions of source code must retain this original header
--   incl. author, contributors, conditions, copyright and disclaimer.
--
-- * Redistributions in synthesized (binary) form must also contain
--   the soure code according to this conditions to keep it "open".
--
-- * Neither the name of the author nor the names of contributors may
--   be used to endorse or promote products derived from this code.
--
-- * This code is only allowed to be used on:
--   - Replay hardware (from fpgaarcade.com)
--
-- * Feedback or bug reports are welcome, but please check on the 
--   web sites given in the header first for any updates available.
--
-- * You are responsible for any legal issues arising from your use
--   or your own distribution of this code.
----------------------------------------------------------------------
-- THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
-- FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
-- AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
-- INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS  CODE OR ANY WORK
-- PRODUCTS, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
----------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity rom_7h is
  port (
    ADDR        : in    std_ulogic_vector(4 downto 0);
    CSn         : in    std_ulogic;
    DATA        : out   std_ulogic_vector(7 downto 0)
    );
end;

architecture RTL of rom_7h is
  type ROM_ARRAY is array(0 to 31) of std_ulogic_vector(7 downto 0);
  constant ROM : ROM_ARRAY := (
    x"3C", x"1B", x"37", x"37", x"3F", x"3F", x"3F", x"3F", -- 0x00
    x"3F", x"1B", x"3F", x"3F", x"B8", x"BF", x"BF", x"BF", -- 0x08
    x"3E", x"3F", x"3F", x"3F", x"3F", x"2A", x"3F", x"3F", -- 0x10
    x"3F", x"3F", x"3F", x"3F", x"BA", x"BA", x"BA", x"BA"  -- 0x18
  );
begin
  p_rom : process(ADDR, CSn)
  begin
    if CSn = '0' then
      DATA <= ROM(to_integer(unsigned(ADDR)));
    else
      DATA <= "11111111";
    end if;
  end process;
end RTL;