%ECE-1254-Multiphisics Systems Modeling-------------
%1 read data and form the netlist to a Gx=b, [G,b]
%2 Using LU decomposition with partial pivoting and obtain L, U
%3 formulate forward and backward substitution and obtain the results
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun

[G,b]=NodalAnalysis('data.txt')
[L,U,r]=LUpartialpivot(G,b);
y=FSM(L,r);
x=BSM(U,y)











