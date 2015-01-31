%ECE-1254-Multiphisics Systems Modeling-------------
%1 clear the Temp
%2 Using netlistgenerator.m to generate the grid netlist
%3 Substitute the prior Problem 1(a)
%4 Solve and plot the values using surf
%Thanks to the Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
clear all
netlistgenerator(50,0.2);
[G,b]=NodalAnalysis('netlist.txt');
[L,U,r]=LUpartialpivot(G,b);
y=FSM(L,r);
x=BSM(U,y)

 N=50; 
 count=1;
 for i=1:(N+1)
     for j=1:(N+1)
         z(i,j)=x(count,1);
         count=count+1;
     end
 end
 
 surf(z);