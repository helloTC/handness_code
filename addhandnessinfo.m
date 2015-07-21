wkdir = 'E:\project\BNU_2015\behavior data\tables\NSPdemography_v2';
rawdir = 'E:\project\BNU_2015\behavior data\tables\handness\origin' ;

%------------------------------06级数据，引用了06_face questionnaire.xlsx,SBSOD raw data 06g&08g.xlsx，BIS_06.xlsx的数据---------------------------------------------%
%06级face数据
[Nface6 Tface6] = xlsread(fullfile(rawdir,'06_face questionnaire'),1);
hand_face6 = Nface6(:,5);
id_face6 = Tface6(:,1);
id_face6(1,:) = [];
id_face6 = cell2mat(id_face6);id_face6(:,1)=[];id_face6 = str2num(id_face6);
hand_face6(isnan(hand_face6))=0;

%06级SOD数据
[Nsbsod6 Tsbsod6] = xlsread(fullfile(rawdir,'SBSOD raw data 06g&08g'),1);
Tsbsod6(1,:) = [];
hand_sbsod6 = Nsbsod6(:,3);
id_sbsod6 = Tsbsod6(:,1);
id_sbsod6 = cell2mat(id_sbsod6);id_sbsod6(:,1)=[];id_sbsod6 = str2num(id_sbsod6);
hand_sbsod6(isnan(hand_sbsod6))=0;

% 06级BIS的数据要通过姓名来进行匹配
[Nread6 Tread6] = xlsread(fullfile(rawdir,'BIS_06'),1);
name_bis6 = Tread6(:,3);
name_bis6(1)=[];
hand_bis6 = Nread6(:,13);
hand_bis6(isnan(hand_bis6))=0;

%------------------------------08级数据，数据引自BIS_08.xlsx，SBSOD raw data 06g&08g.xlsx--------------------------------------------------%
%08级sbsod数据
[Nsbsod8 Tsbsod8] = xlsread(fullfile(rawdir,'SBSOD raw data 06g&08g'),2);
Tsbsod8(1,:) = [];
hand_sbsod8 = Nsbsod8(:,11);
name_sbsod8 = Tsbsod8(:,2);
hand_sbsod8(isnan(hand_sbsod8))=0;






%08级BIS数据
[Nread8 Tread8] = xlsread(fullfile(rawdir,'BIS_08'),1);
Tread8(1,:) = [];
name_bis8 = Tread8(:,2);
hand_bis8 = Nread8(:,13);
hand_bis8(isnan(hand_bis8))=0;

% Import the whole nspid data.
fileall = 'E:\project\BNU_2015\behavior data\tables\NSPdemography_v2\subjDemography';
fid = fopen(fullfile(fileall,'nspSubjID.txt'));
C = textscan(fid,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t\n','delimiter','\t','headerlines',1);
fclose(fid);
Csid = C{2};
Csid = char(Csid);Csid(:,1)=[];Csid = str2num(Csid);
Csid_06 = Csid(Csid<1000);
Csid_08 = Csid(Csid>999);
Cname = C{4};
Cname_06 = Cname(Csid<1000);
Cname_08 = Cname(Csid>999);



% transfer name of bis6,bis8 and sbsod8 to
% nspid.
    id_bis6 = zeros(length(name_bis6),1);
    id_bis8 = zeros(length(name_bis8),1);
    id_sbsod8 = zeros(length(name_sbsod8),1);
    repeat6 = 0;
    repeat8 = 0;
    repeat_sbsod8 = 0;
    empty6 = 0;
    empty8 = 0;
    empty_sbsod8 = 0;
for i = 1:length(name_bis6)
    if length(Csid_06(strcmp(name_bis6(i),Cname_06)))>1
        repeat6 = repeat6+1;
        continue;
    end
    if isempty(Csid_06(strcmp(name_bis6(i),Cname_06)))
        empty6 = empty6+1;
        continue;
    end
    id_bis6(i) = Csid_06(strcmp(name_bis6(i),Cname_06)) ;
end
for j = 1:length(name_bis8)
    if length(Csid_08(strcmp(name_bis8(j),Cname_08)))>1
        repeat8 = repeat8+1;
        continue;
    end
    if isempty(Csid_08(strcmp(name_bis8(j),Cname_08)))
        empty8 = empty8+1;
        continue;
    end
    id_bis8(j) = Csid_08(strcmp(name_bis8(j),Cname_08));
end
for k = 1:length(name_sbsod8)
    if length(Csid_08(strcmp(name_sbsod8(k),Cname_08)))>1
        repeat_sbsod8 = repeat_sbsod8+1;
        continue;
    end
    if isempty(Csid_08(strcmp(name_sbsod8(k),Cname_08)))
        empty_sbsod8 = empty_sbsod8 + 1;
        continue;
    end
    id_sbsod8(k) = Csid_08(strcmp(name_sbsod8(k),Cname_08));
end

id6 = unique(sort([id_bis6 ; id_sbsod6 ; id_face6]));
if id6(1)==0
    id6(1) =[];
end
id8 = unique(sort([id_bis8 ; id_sbsod8]));
if id8(1)==0
    id8(1) = [];
end

%输出量一，id
id = [id6;id8];
%输出量 量表数据
id_output_face6 = zeros(length(id6),1);
id_output_bis6 = zeros(length(id6),1);
id_output_sbsod6 = zeros(length(id6),1);

id_output_bis8 = zeros(length(id8),1);
id_output_sbsod8 = zeros(length(id8),1);

for i = 1:length(id6)
    if isempty(hand_face6(id_face6 == id6(i)))
        continue;
    end
    id_output_face6(i) = hand_face6(id_face6 == id6(i));
end
for i = 1:length(id6)
    if isempty(hand_bis6(id_bis6 == id6(i)))
        continue;
    end
    id_output_bis6(i) = hand_bis6(id_bis6 == id6(i));
end
for i = 1:length(id6)
    if isempty(hand_sbsod6(id_sbsod6 == id6(i)))
        continue;
    end
    id_output_sbsod6(i) = hand_sbsod6(id_sbsod6 == id6(i));
end
for i = 1:length(id8)
    if isempty(hand_bis8(id_bis8 == id8(i)))
        continue;
    end
    id_output_bis8(i) = hand_bis8(id_bis8 == id8(i));
end
for i = 1:length(id8)
    if isempty(hand_sbsod8(id_sbsod8 == id8(i)))
        continue;
    end
    id_output_sbsod8(i) = hand_sbsod8(id_sbsod8 == id8(i));
end
id_output_face8 = zeros(length(id8),1);
id_output_face = [id_output_face6;id_output_face8];
id_output_sbsod = [id_output_sbsod6;id_output_sbsod8];
id_output_bis = [id_output_bis6;id_output_bis8];


final_hand = zeros(length(id),1);
% 三个量表中出现次数最多的handness
M_mode = zeros(length(id),1);
% 三个量表中出现次数最多的handness的次数
F_mode = zeros(length(id),1);
for i = 1:length(id)
    [M_mode(i) F_mode(i)] = mode([id_output_face(i) id_output_sbsod(i) id_output_bis(i)]);
    if F_mode(i) == 1
        final_hand(i) = 3;
    elseif F_mode(i) == 2
           if M_mode(i) == 0
               final_hand(i) = sum([id_output_face(i) id_output_sbsod(i) id_output_bis(i)]);
            else final_hand(i) = M_mode(i);
           end
    else final_hand(i) = M_mode(i);
    end
end


id_cell = cell(length(id),1);
id_cell6 = cell(length(id6),1);
id_cell8 = cell(length(id8),1);
id_rawa = 'S0000';
for i = 1:length(id)
    id_rawa(end-length(num2str(id(i)))+1:end) = num2str(id(i));
    id_cell{i} = id_rawa;
    id_rawa = 'S0000';
end
for i = 1:length(id6)
    id_rawa(end-length(num2str(id6(i)))+1:end) = num2str(id6(i));
    id_cell6{i} = id_rawa;
    id_rawa = 'S0000';
end
for i = 1:length(id8)
    id_rawa(end-length(num2str(id8(i)))+1:end) = num2str(id8(i));
    id_cell8{i} = id_rawa;
    id_rawa = 'S0000';
end


% Output data as excel files.
% It will output 3 excel files,
% output_handness_all.xlsx,which contains
% NSPID of all subjects,no matter 06 & 08,handness of face,handness of
% SBSOD,handness of BIS,handness of Final_hand.
% output_handness6.xlsx,it contains only subjects of 06,for convenience of
% proofreading,this file do not contains final_hand.
% output_handness8.xlsx,it contains only subjects of 08,the format of this file
% is same as output_handness6.xlsx.




xlswrite('output_handness_all.xlsx',[{'NSPID'},{'FACE'},{'SBSOD'},{'BIS'},{'FINAL_HAND'}],1,'A1');
xlswrite('output_handness_all.xlsx',id_cell,1,'A2');
xlswrite('output_handness_all.xlsx',[id_output_face,id_output_sbsod,id_output_bis,final_hand],1,'B2');



%------------output_handness6.xlsx--------------------------
xlswrite('output_handness6.xlsx',[{'NSPID'},{'FACE'},{'SBSOD'},{'BIS'}],1,'A1');
xlswrite('output_handness6.xlsx',id_cell6,1,'A2');
xlswrite('output_handness6.xlsx',[id_output_face6,id_output_sbsod6,id_output_bis6],1,'B2');

xlswrite('output_handness6.xlsx',[{'NSPID'},{'FACE'}],2,'A1');
xlswrite('output_handness6.xlsx',id_cell6,2,'A2');
xlswrite('output_handness6.xlsx',[id_output_face6],2,'B2');

xlswrite('output_handness6.xlsx',[{'NSPID'},{'SBSOD'}],3,'A1');
xlswrite('output_handness6.xlsx',id_cell6,3,'A2');
xlswrite('output_handness6.xlsx',[id_output_sbsod6],3,'B2');

xlswrite('output_handness6.xlsx',[{'NSPID'},{'BIS'}],4,'A1');
xlswrite('output_handness6.xlsx',id_cell6,4,'A2');
xlswrite('output_handness6.xlsx',[id_output_bis6],4,'B2');

%------------output_handness8.xlsx-----------------------------

xlswrite('output_handness8.xlsx',[{'NSPID'},{'FACE'},{'SBSOD'},{'BIS'}],1,'A1');
xlswrite('output_handness8.xlsx',id_cell8,1,'A2');
xlswrite('output_handness8.xlsx',[id_output_face8,id_output_sbsod8,id_output_bis8],1,'B2');

xlswrite('output_handness8.xlsx',[{'NSPID'},{'FACE'}],2,'A1');
xlswrite('output_handness8.xlsx',id_cell8,2,'A2');
xlswrite('output_handness8.xlsx',[id_output_face8],2,'B2');

xlswrite('output_handness8.xlsx',[{'NSPID'},{'SBSOD'}],3,'A1');
xlswrite('output_handness8.xlsx',id_cell8,3,'A2');
xlswrite('output_handness8.xlsx',[id_output_sbsod8],3,'B2');

xlswrite('output_handness8.xlsx',[{'NSPID'},{'BIS'}],4,'A1');
xlswrite('output_handness8.xlsx',id_cell8,4,'A2');
xlswrite('output_handness8.xlsx',[id_output_bis8],4,'B2');




% Code below is aim to print final_handness data into final
% files,nspSubjID-1.txt
fid = fopen(fullfile(wkdir,'SubjDemography','nspSubjID-1.txt'));
C = textscan(fid,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t\n','delimiter','\t','headerlines',1);
fclose(fid);


Csid = C{2};
Csid = cell2mat(Csid);
Csid(:,1) = [];
Csid = str2num(Csid);
Chand = zeros(length(Csid),1);


for i = 1:length(Csid)
    if ~isempty(find(Csid(i) == id))
        Chand(i) = final_hand(Csid(i) == id);
    else continue;
    end
end


% 
% Cname = C{4};
% Csid = C{2};
% 
% %Paired that when Csid == sid06 ,then assign hand06 to Chand.
% Chand = zeros(length(Csid),1);
% for i=1:length(Csid)
%     for j = 1:nSubj06
%        if strcmp(Csid{i},sid06(j))
%             Chand(i) = hand06(j);
%        end
%     end
% end
% %Paired that when Cname == name08 ,then assign hand08 to Chand.
% for i = 1:length(Cname)
%     for j =1:nSubj08
%         if strcmp(Cname(i),name08(j))
%             Chand(i) = hand08(j);
%         end
%     end
% end
% % --------------------------------------------------------------------------



fid = fopen(fullfile(wkdir,'SubjDemography','nspSubjID-1.txt'),'w');
fprintf(fid,' %s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\n','BLOODID','NSPID','NAME','CHINSESNAME','SEX','GRADE','HasMRI','HasSNP','Handness');
for i = 1:length(Chand)
    fprintf(fid,' %s\t %s\t %s\t %s\t %d\t %d\t %d\t %d\t %d\n',C{1}{i},C{2}{i},C{3}{i},C{4}{i},C{5}(i),C{6}(i),C{7}(i),C{8}(i),Chand(i));
end
fclose(fid);


