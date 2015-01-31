%ECE-1254-Multiphisics Systems Modeling-------------
%generate the leaky bar list
%Thanks to the following reference materials:
%1.Course notes and ppt from Professor Piero at University of Toronto
%Chen Sun

function barList(step)

n_section=1/step; %number of sections along bar
nodes=n_section+1;
k_m=0.1;
k_a=0.001;
hor_res=step^2/k_m;
vert_res=1/k_a;
ref_node=0;
tempC={'V(0)','1',num2str(ref_node),'DC','250',' '}; %cell array used to copy to textfile

fid=fopen('barList.txt','w');
fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});

tempC={'V(1)',num2str(nodes),num2str(ref_node),'DC','250',' '};
fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});

tempC={'V0',num2str(nodes+1),num2str(ref_node),'DC','400',' '};
fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});


length=step; % helps in iteration
j=1;
k=1; %keeps track of current source numbering
%loop for copying sections into text file
for i=1:(n_section-1)
    %adding horizontal resistor
    tempC{1}=cat(2,'R',num2str(j));
    tempC{2}=num2str(i);
    tempC{3}=num2str(i+1);
    tempC{4}=num2str(hor_res);
    tempC{5}=' ';
    
    fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});
    j=j+1; %keeps track of resistor numbering
    %adding vertical resistor    
    tempC{1}=cat(2,'R',num2str(j));
    tempC{2}=num2str(i+1);
    tempC{3}=num2str(nodes+1);
    tempC{4}=num2str(vert_res);
    tempC{5}=' ';
    fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});
   
    %adding current source
    tempC{1}=cat(2,'I',num2str(k));
    tempC{2}=num2str(ref_node);
    tempC{3}=num2str(i+1);
    tempC{4}='DC';
    tempC{5}=num2str(50*(sin(2*pi*length))^2);
    fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});
    
    j=j+1;
    k=k+1;  
    
    length=length+step;
    
end

tempC{1}=cat(2,'R',num2str(j));
tempC{2}=num2str(n_section);
tempC{3}=num2str(nodes);
tempC{4}=num2str(hor_res);
tempC{5}=' ';
    
 fprintf(fid,'%s %s %s %s %s %s\r\n',tempC{1},tempC{2},tempC{3},tempC{4},tempC{5},tempC{6});

fclose(fid);

