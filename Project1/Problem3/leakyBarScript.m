%ECE-1254-Multiphisics Systems Modeling-------------
%1 read data and form the netlist to a Gx=b, [G,b]
%2 Using LU decomposition with partial pivoting and obtain L, U
%3 formulate forward and backward substitution and obtain the results
%4 plot the results
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun

clear all

step=1e-3;
barList(step);
[G,b]=NodalAnalysis('barList.txt');
[L,U,r]=LUpartialpivot(G,b);
y=FSM(L,r);
x=BSM(U,y);
node_num=length(x)-4; %number of node potentials
n=1:node_num; 
plot((n-1)*step,x(1:node_num,1));
xlabel(' Along  leaky bar', 'fontsize',16);
ylabel('Temperature', 'fontsize',16);
