%ECE-1254-Multiphisics Systems Modeling-------------
%Routine generate Forwad subsitution-------------------------
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
function y= FSM(L,b)
y=zeros(length(L(1,:)),1);
y(1,1)=b(1,1)/L(1,1);
%forward substitution begins-----------------
for i=2:length(b)
    sum=0;    
    for j=1:i-1
        sum=sum+(L(i,j)*y(j,1));
    end
    y(i,1)=(b(i,1)-sum)/L(i,i);  
end
%forward substitution over-----------------