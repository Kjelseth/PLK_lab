library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
	port(C_in : in  std_logic;
		 U  : in  std_logic;
		 V  : in  std_logic;
		 S_out  : out std_logic;
		 C_out : out std_logic);
end fullAdder;

architecture strucural of fullAdder is

begin

	S_out <= (((not C_in) and (not V) and U) or
			 ((not C_in) and V and (not U)) or
			 (C_in and (not V) and (not U)) or
			 (C_in and V and U));
		  
	C_out <= ((V and U) or
			 (C_in and U) or
			 (C_in and V));

end strucural;