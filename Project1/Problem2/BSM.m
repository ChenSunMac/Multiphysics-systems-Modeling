%ECE-1254-Multiphisics Systems Modeling-------------
%Routine generate backward substitution-------------------------
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
function x= BSM(U,y)
n=length(U(1,:));
x=zeros(n,1);
x(n,1)=y(n,1)/U(n,n);
%backward substitution begin------------------
for i=n-1:-1:1
    sum=0;    
   for j=i+1:n
       sum=sum+(U(i,j)*x(j,1));
   end   
   x(i,1)= (y(i,1)-sum)/U(i,i);    
end
%backward substitution over------------------