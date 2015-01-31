%ECE-1254-Multiphisics Systems Modeling-------------
%1 read data and form the netlist to a Gx=b, [G,b]
%2 Using LU decomposition with partial pivoting and obtain L, U
%3 formulate forward and backward substitution and obtain the results
%4 plot the results
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun

clear all

step=0.001;
barList2(step);
[G,b]=NodalAnalysis('barList2.txt');
[L,U,r]=LUpartialpivot(G,b);
y=FSM(L,r);
x=BSM(U,y);
node_num=length(x)-2; %number of node potentials
n=1:node_num; 
figure
plot((n-1)*step,x(1:node_num,1));
xlabel(' Along the leaky bar', 'fontsize',16);
ylabel('Temperature', 'fontsize',16);
%ConvertPlot4Publication('mycopy','eps','off','keepvertical','on','height',2,'fontsize',9);