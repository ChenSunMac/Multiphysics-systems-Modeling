%ECE-1254-Multiphisics Systems Modeling-------------
%This is to plot the CPU time.
%Note that I was using my own personal laptop to do this, n should not
%exceed 55,once it did, there will not be enough for the memory. 
%However, If the memory is possible, the picture shape will be more analogy
%to exponetial function as n -> 100
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
clear all
n=5:5:50; % number of resistors per edge of the square grid
for i=1:length(n)
 netlistgenerator(n(1,i),0.2);
 [G,b]=NodalAnalysis('netlist.txt');
 tstart=tic;
 [L,U,r]=LUpartialpivot(G,b);
 y=FSM(L,r);
 x=BSM(U,y)
 time_stamp(1,i)=toc(tstart);
 mat_size(1,i)=(n(1,i)+1)^2+1;
end

plot(mat_size,time_stamp);
xlabel('Matrix size', 'fontsize',16);
ylabel('Time (seconds)', 'fontsize',16);
axis([0 3000 0 700])
grid on
