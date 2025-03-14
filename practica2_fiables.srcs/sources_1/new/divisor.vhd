library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_3 is
    port(
        clk         : in  std_logic;
        ena         : in  std_logic;
        f_div_2_5   : out std_logic;
        f_div_1_25  : out std_logic;
        f_div_500   : out std_logic
    );
end entity divisor_3;

architecture Behavioral of divisor_3 is
--contadores para dividir la frequencia
    signal contador40 : unsigned(5 downto 0) := (others => '0'); -- para hacer contador de 40 se necesitan 6 bits, sumando en binario
    signal contador80 : unsigned(6 downto 0) := (others => '0'); -- para el resto igual
    signal contador200 : unsigned(7 downto 0) := (others => '0');

    signal pulso_2_5   : std_logic := '0';
    signal pulso_1_25  : std_logic := '0';
    signal pulso_500   : std_logic := '0';

begin
    process(clk, ena)
    begin
    --Cuando el enable este a 0, todo se reestablece a 0
        if ena = '0' then
            contador40 <= (others => '0');
            contador80 <= (others => '0');
            contador200 <= (others => '0');
            pulso_2_5 <= '0';
            pulso_1_25 <= '0';
            pulso_500 <= '0';
        elsif rising_edge(clk) then
            
            -- Para 2.5 MHz
            if contador40 = 39 then
                contador40 <= (others => '0');
                pulso_2_5 <= '1';
            else
                contador40 <= contador40 + 1;
                pulso_2_5 <= '0';
            end if;
            
            -- Para 1.25MHz 
            if contador80 = 79 then
                contador80 <= (others => '0');
                pulso_1_25 <= '1';
            else
                contador80 <= contador80 + 1;
                pulso_1_25 <= '0';
            end if;
            
            --  Para 500KHz
            if contador200 = 199 then
                contador200 <= (others => '0');
                pulso_500 <= '1';
            else
                contador200 <= contador200 + 1;
                pulso_500 <= '0';
            end if;
        end if;
    end process;

    -- igualamos las salidas a los pulsos calculados
    f_div_2_5  <= pulso_2_5;
    f_div_1_25 <= pulso_1_25;
    f_div_500  <= pulso_500;
    
end Behavioral;
