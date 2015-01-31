%ECE-1254-Multiphisics Systems Modeling-------------
%Routine generate LU decomposition with partial pivoting-------------------------
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
function [L,U,b]= LUpartialpivot(M,b)
%------Initialization----------------
n=length(M(1,:)); %determines dimension of matrix M

%-----Partial--Pivoting----------------
for i=1:n-1
    %search for the largest pivot to use
    max_pivot=abs(M(i,i)); %|M(i,i)|
    max_pos=i;
    
    for j=i+1:n
        if(max_pivot<abs(M(j,i)))
            max_pivot=abs(M(j,i));
            max_pos=j;
        end
    end
    %search over------------------------
    
    %swapping rows----------------------
    hold_mat=M(i,:); 
    hold_vec=b(i,1);
    M(i,:)=M(max_pos,:);
    b(i,1)=b(max_pos,1);
    M(max_pos,:)=hold_mat;
    b(max_pos,1)=hold_vec;
    %swap over--------------------------
    %update of matrix M with multipliers and new terms
    for j=i+1:n
        M(j,i)=M(j,i)/M(i,i);
            for k=i+1:n
                M(j,k)=M(j,k)-(M(j,i)*M(i,k));
            end       
    end  
end

L=eye(n);
U=zeros(n);
%LU------decomposition------------------
for i=2:n
    L(i,1:i-1)=M(i,1:i-1);
end

for i=1:n
    U(i,i:n)=M(i,i:n);
end
%LU decomposition over







