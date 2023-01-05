----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:18 01/05/2023 
-- Design Name: 
-- Module Name:    newproject - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity project is
    port( clk: in std_logic;
        startnode: in integer;
        Q:out integer
			 );	
end project ;
architecture path of project is
type weight is array (5 downto 0,5 downto 0)  of integer ;
type parray is array(5 downto 0) of  integer;
signal w:weight :=((0,1,4,0,0,0),(1,0,4,2,7,0),(4,4,0,3,5,0),(0,2,3,0,4,6),(0,7,5,4,0,7),(0,0,0,6,7,0));
shared variable Parent:parray:=(0,0,0,0,0,0);
shared variable valuee:parray:=(0,99999,99999,99999,99999,99999);
shared variable processed:parray:=(0,0,0,0,0,0);
shared variable paths:parray;
shared variable u:integer;
shared variable endnode : integer;

function minimumvertex(valuee: in parray;processed: in parray) return integer is 
variable vertex:integer;
variable mini:integer:=99999;
begin


for i in 0 to 5 loop
if(processed(i)=0 and valuee(i)<mini) then
vertex:=i;
mini:=valuee(i);

end if;
end loop;
return vertex;
end function minimumvertex;



procedure dijestra(x:weight)is 
variable i:integer:=0;

begin


for i in 0 to 4 loop
u:= minimumvertex(valuee,processed);
processed(u):=1; 

for j in 0 to 5 loop
if(w(u,j)/=0 and processed(j)=0 and valuee(u)/=99999 and (valuee(u)+w(u,j)<valuee(j))) then
valuee(j):=valuee(u)+w(u,j);
parent(j):=u;

end if;
end loop;
end loop;
endnode:=3;

while(endnode/=0  and i<6)loop
paths(i):=parent(endnode);
endnode:=parent(endnode);
i:=i+1;
end loop;
end procedure dijestra;

begin
process(startnode,w) is
begin
dijestra(w);
end process;


process(clk) is 
begin
for i in 0 to 5 loop
if rising_edge(clk) then --not finished
Q<=paths(i);
end if;
end loop;
end process;


end path;