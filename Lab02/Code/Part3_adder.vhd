library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
	port(Ci : in  std_logic;
		 A  : in  std_logic;
		 B  : in  std_logic;
		 S  : out std_logic;
		 Co : out std_logic);
end fullAdder;

architecture strucural of fullAdder is

begin

	S  <= (((not Ci) and (not B) and A) or
		  ((not Ci) and B and (not A)) or
		  (Ci and (not B) and (not A)) or
		  (Ci and B and A));
		  
	Co <= ((B and A) or
		  (Ci and A) or
		  (Ci and B));

end strucural;