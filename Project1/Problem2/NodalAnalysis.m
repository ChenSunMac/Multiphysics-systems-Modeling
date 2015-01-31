%ECE-1254-Multiphisics Systems Modeling-------------
%Generate the MNA equation------------------------
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun

function [G,b]=NodalAnalysis(filename)
%------read from text file--------------------------
fid=fopen(filename); 
temp=textscan(fid, '%s %s %s %s %s %s');
fclose(fid);
%------copy infos

E_label=temp{1}; 
E_data(:,1)=str2double(temp{2});
E_data(:,2)=str2double(temp{3});
E_data(:,3)=str2double(temp{4});
E_data(:,4)=str2double(temp{5});
E_data(:,5)=str2double(temp{6});
%Initialize----------------------------------------
M=length(E_label); 
max_node=-1;
volt_num=0; 
ref_node=0; 
zero_node=0; 
%--------------------------------------------------

%count node potentials compute for V
for m=1:M
    if(E_data(m,1)==0 || E_data(m,2)==0)
        zero_node=1;
    end
    
    if(max(E_data(m,1),E_data(m,2))>max_node)
        max_node=max(E_data(m,1),E_data(m,2));
    end
    
    if((strncmpi(E_label(m,1),'V',1)==1)|| (strncmpi(E_label(m,1),'E',1)==1))
        volt_num=volt_num+1;
    end
end

if(zero_node==0)
    max_node=max_node-1;
end

%Initialize G and b matrix
G_size=max_node+volt_num;
G=zeros(G_size);
b=zeros(G_size,1);
%point out the index of the extra equation
vol_row=max_node+1;

%Stamp elements------------------------------------
for m=1:M
    
    %---------Adding conductance stamp--------------
    if(strncmpi(E_label(m,1),'R',1)==1)
        if(E_data(m,1)~=ref_node)
            j=E_data(m,1);
            G(j,j)=G(j,j)+(1/E_data(m,3));
        end
        
        if(E_data(m,2)~=ref_node)
            j=E_data(m,2);
            G(j,j)=G(j,j)+(1/E_data(m,3));
        end
        
        if((E_data(m,1)~=ref_node) && (E_data(m,2)~=ref_node))
            i=E_data(m,1);
            j=E_data(m,2);
            G(i,j)=G(i,j)-(1/E_data(m,3));
            G(j,i)=G(j,i)-(1/E_data(m,3));    
        end
    end
    
    %Adding I element stamp
    if(strncmpi(E_label(m,1),'I',1)==1)
       
        if(E_data(m,1)~=ref_node)
            j=E_data(m,1);
            b(j,1)=b(j,1)-E_data(m,4);
        end
        
        if(E_data(m,2)~=ref_node)
            j=E_data(m,2);
            b(j,1)=b(j,1)+E_data(m,4);
        end
        
    end
    
    %Adding independent voltage source stamp-------------------
    if(strncmpi(E_label(m,1),'V',1)==1)
        if(E_data(m,1)~=ref_node)
            j=E_data(m,1);
            G(j,vol_row)=-1;
            G(vol_row,j)=+1;
        end
        
        if(E_data(m,2)~=ref_node)
            j=E_data(m,2);
            G(j,vol_row)=+1;
            G(vol_row,j)=-1;
        end        
     b(vol_row,1)=E_data(m,4);
     vol_row=vol_row+1;
    end
    
    %Adding VSVC stamp
    if(strncmpi(E_label(m,1),'E',1)==1)
        if(E_data(m,1)~=ref_node)
            j=E_data(m,1);
            G(j,vol_row)=-1;
            G(vol_row,j)=+1;
        end        
        if(E_data(m,2)~=ref_node)
            j=E_data(m,2);
            G(j,vol_row)=+1;
            G(vol_row,j)=-1;
        end         
        if(E_data(m,3)~=ref_node)
            j=E_data(m,3);
            G(vol_row,j)=G(vol_row,j)-E_data(m,5);
        end        
        if(E_data(m,4)~=ref_node)
            j=E_data(m,4);
            G(vol_row,j)=G(vol_row,j)+E_data(m,5);
        end
        vol_row=vol_row+1;
  end 
    
end
