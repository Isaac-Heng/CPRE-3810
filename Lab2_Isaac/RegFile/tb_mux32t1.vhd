library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.regfile_pkg.all;  

entity tb_mux_32t1 is
end tb_mux_32t1;

architecture sim of tb_mux_32t1 is
  constant cCLK_PER : time := 10 ns;


  component mux_32t1 is
    port (
      i_32 : in  reg_array;
      s_i  : in  std_logic_vector(4 downto 0);
      o_1  : out std_logic_vector(31 downto 0)
    );
  end component;

  signal s_i32 : reg_array := (others => (others => '0'));
  signal s_sel : std_logic_vector(4 downto 0) := (others => '0');
  signal s_out : std_logic_vector(31 downto 0);

begin
  DUT : mux_32t1
    port map (
      i_32 => s_i32,
      s_i  => s_sel,
      o_1  => s_out
    );

  P_TB : process
  begin
    -- Test case 1: Select register 1
    s_i32(1) <= x"11111111";
    s_sel    <= "00001";
    wait for cCLK_PER;
    -- Expect o_1 = 11111111

    -- Test case 2: Select register 5
    s_i32(5) <= x"AAAAAAAA";
    s_sel    <= "00101";
    wait for cCLK_PER;
    -- Expect o_1 = AAAAAAAA

    -- Test case 3: Select register 10
    s_i32(10) <= x"12345678";
    s_sel     <= "01010";
    wait for cCLK_PER;
    -- Expect o_1 = 12345678

    -- Test case 4: Select register 7
    s_i32(7) <= x"00FF00FF";
    s_sel     <= "00111";
    wait for cCLK_PER;
    -- Expect o_1 = 00FF00FF

    -- Test case 5: Select register 20
    s_i32(20) <= x"F0F0F0F0";
    s_sel     <= "10100";
    wait for cCLK_PER;
    -- Expect o_1 = F0F0F0F0

    wait;
  end process;
end sim;


