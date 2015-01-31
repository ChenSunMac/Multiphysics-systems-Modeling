%ECE-1254-Multiphisics Systems Modeling-------------
% generates a netlist for NXN square grid
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun
function netlistgenerator(N,r)

    ref_node=0;                     %reference node
    IMin=0.01;                      %min current value
    IMax=-.1;                       %max current value

temp={'v','1',num2str(ref_node),'DC','1',' '};              %cell array used to copy to textfile

fid=fopen('netlist.txt','w');
fprintf(fid,'%s %s %s %s %s %s\r\n',temp{1},temp{2},temp{3},temp{4},temp{5},temp{6});

k=0; 

%-----loop for copying horizontal resistors into text file----------
for i=1:(N*(N+1))
    temp{1}=cat(2,'R',num2str(i));
    temp{2}=num2str(i+k);
    temp{3}=num2str(i+k+1);
    temp{4}=num2str(r);
    temp{5}=' ';
    
    fprintf(fid,'%s %s %s %s %s %s\r\n',temp{1},temp{2},temp{3},temp{4},temp{5},temp{6});
    
    if(rem(i,N)==0)
        k=k+1;
    end
end

off_set=N*(N+1);
%--copying the vertical resistors into the textFile---------------
for i=1:(N*(N+1))
    temp{1}=cat(2,'R',num2str(i+off_set));
    temp{2}=num2str(i);
    temp{3}=num2str(i+N+1);
    temp{4}=num2str(r);
    temp{5}=' ';
    
    fprintf(fid,'%s %s %s %s %s %s\r\n',temp{1},temp{2},temp{3},temp{4},temp{5},temp{6});
end


 %--------generates current values for the sources in specified range--
 currentVal= IMin+((IMax-IMin).*rand(1,3));
 %--------adding current sources into the textfile----------------
 for i=1:3
  temp{1}=cat(2,'I',num2str(i));
  count=0;
 while count==0
    curr=ceil(rand(1)*(N+1)^2);
    if(curr~=ref_node && curr~=0)
        count=1;
    end
 end
  temp{2}=num2str(curr);
  temp{3}=num2str(ref_node);
  temp{4}='DC';
  temp{5}=num2str(currentVal(1,i));
    
    fprintf(fid,'%s %s %s %s %s %s\r\n',temp{1},temp{2},temp{3},temp{4},temp{5},temp{6});
 
 end
 
fclose(fid);