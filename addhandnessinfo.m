 wkdir = 'E:\project\BNU_2015\behavior data\tables\NSPdemography_v2';


%-------------使用raw file并根据某种算法计算得到final_hand的代码-------------

% The stream of whole code is like this:
% First,we get handness & id of three scales,assign them to different
% variables
% Second,find out the unique & max sid for further analysis.That's means
% the whole subjects
% Third,we judge different situations then assign handness values to the
% final_hand variables.
% Finally,output final_hand.

rawdir = 'E:\project\BNU_2015\behavior data\tables\handness\origin' ;

%------------------------------06级数据，引用了06_face questionnaire.xlsx,SBSOD raw data 06g&08g.xlsx，BIS_06.xlsx的数据---------------------------------------------%
%06级face数据
[Nface6 Tface6] = xlsread(fullfile(rawdir,'06_face questionnaire'),2);
hand_face6 = Nface6(:,6);
id_face6 = Nface6(:,1);
hand_face6(isnan(hand_face6))=0;

%06级SOD数据
[Nsob6 Tsob6] = xlsread(fullfile(rawdir,'SBSOD raw data 06g&08g'),1);
Tsob6(1,:) = [];
hand_sob6 = Nsob6(:,3);
id_sob6 = char(Tsob6(:,1));
id_sob6(:,1) = [];
id_sob6 = str2num(id_sob6);
% name_sob6 = Tsob6(:,2);
hand_sob6(isnan(hand_sob6))=0;

% 06级BIS的数据要通过姓名来进行匹配
[Nread6 Tread6] = xlsread(fullfile(rawdir,'BIS_06'),1);
name_bis6 = Tread6(:,3);
name_bis6(1)=[];
hand_bis6 = Nread6(:,13);
hand_bis6(isnan(hand_bis6))=0;

%------------------------------08级数据，数据引自BIS_08.xlsx，SBSOD raw data 06g&08g.xlsx--------------------------------------------------%
%08级sob数据
[Nsob8 Tsob8] = xlsread(fullfile(rawdir,'SBSOD raw data 06g&08g'),2);
Tsob8(1,:) = [];
hand_sob8 = Nsob8(:,13);
% id_sob8 = Nsob8(:,1);
name_sob8 = Tsob8(:,2);
hand_sob8(isnan(hand_sob8))=0;






%08级BIS数据
[Nread8 Tread8] = xlsread(fullfile(rawdir,'BIS_08'),1);
Tread8(1,:) = [];
name_bis8 = Tread8(:,2);
hand_bis8 = Nread8(:,13);
hand_bis8(isnan(hand_bis8))=0;

%导入全被试数据

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



% 将bis6和bis8的name转换成ssid 加sob8
    id_bis6 = zeros(length(name_bis6),1);
    id_bis8 = zeros(length(name_bis8),1);
    id_sob8 = zeros(length(name_sob8),1);
    repeat6 = 0;
    repeat8 = 0;
    repeat_sob8 = 0;
    empty6 = 0;
    empty8 = 0;
    empty_sob8 = 0;
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
for k = 1:length(name_sob8)
    if length(Csid_08(strcmp(name_sob8(k),Cname_08)))>1
        repeat_sob8 = repeat_sob8+1;
        continue;
    end
    if isempty(Csid_08(strcmp(name_sob8(k),Cname_08)))
        empty_sob8 = empty_sob8 + 1;
        continue;
    end
    id_sob8(k) = Csid_08(strcmp(name_sob8(k),Cname_08));
end

id6 = unique(sort([id_bis6 ; id_sob6 ; id_face6]));
if id6(1)==0
    id6(1) =[];
end
id8 = unique(sort([id_bis8 ; id_sob8]));
if id8(1)==0
    id8(1) = [];
end

%输出量一，id
id = [id6;id8];
%输出量 量表数据
id_output_face6 = zeros(length(id6),1);
id_output_bis6 = zeros(length(id6),1);
id_output_sob6 = zeros(length(id6),1);

id_output_bis8 = zeros(length(id8),1);
id_output_sob8 = zeros(length(id8),1);

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
    if isempty(hand_sob6(id_sob6 == id6(i)))
        continue;
    end
    id_output_sob6(i) = hand_sob6(id_sob6 == id6(i));
end
for i = 1:length(id8)
    if isempty(hand_bis8(id_bis8 == id8(i)))
        continue;
    end
    id_output_bis8(i) = hand_bis8(id_bis8 == id8(i));
end
for i = 1:length(id8)
    if isempty(hand_sob8(id_sob8 == id8(i)))
        continue;
    end
    id_output_sob8(i) = hand_sob8(id_sob8 == id8(i));
end
id_output_face8 = zeros(length(id8),1);
id_output_face = [id_output_face6;id_output_face8];
id_output_sob = [id_output_sob6;id_output_sob8];
id_output_bis = [id_output_bis6;id_output_bis8];


final_hand = zeros(length(id),1);
% 三个量表中出现次数最多的handness
M_mode = zeros(length(id),1);
% 三个量表中出现次数最多的handness的次数
F_mode = zeros(length(id),1);
for i = 1:length(id)
    [M_mode(i) F_mode(i)] = mode([id_output_face(i) id_output_sob(i) id_output_bis(i)]);
    if F_mode(i) == 1
        final_hand(i) = 3;
    elseif F_mode(i) == 2
           if M_mode(i) == 0
               final_hand(i) = sum([id_output_face(i) id_output_sob(i) id_output_bis(i)]);
            else final_hand(i) = M_mode(i);
           end
    else final_hand(i) = M_mode(i);
    end
end

A_exceloutput = [id,id_output_face,id_output_sob,id_output_bis,final_hand];
xlswrite('output_handness.xlsx',A_exceloutput);


    

Chand = final_hand;





% % -----------------未使用raw file之前的代码----------------------------------
% %Output file includes handness information.
% %1 means left handness,2 means right handness,3 means both handness
% %0 means data lost
% 
% 
% disp('add handness infomation');
% 
% 
% %Load in data from 2006_handness.xlsx and 2008SubjHandedness.xlsx
% %Due to next operation need to index data by different rules,we must get
% %these index out.
% 
% %By reminding,the data from 2006_handness.xlsx need to index by sid numbers
% %The data from 2008SubjHandedness.xlsx need to index by subjects' name.

% [~,handness] = xlsread(fullfile(wkdir,'2006','2006_handness.xlsx'),1);
% handness(1,:) = [];
% nSubj06 = length(handness);
% sid06 = handness(:,1);
% 
% [hand08,name08] = xlsread(fullfile(wkdir,'2008','2008SubjHandedness.xlsx'),1);
% nSubj08 = length(hand08);
% hand08 = hand08(:,2);
% name08(1,:)=[];name08(:,2:3)=[];
% hand08(isnan(hand08))=0;
% 
% 
% %Motified handness info in 2006 by replacing word into numbers
% for i = 1:nSubj06
%     if strcmp(handness{i,8},'left')
%         hand06{i} = 1;
%     elseif strcmp(handness{i,8},'right')
%         hand06{i} = 2;
%     else strcmp(handness{i,8},'both')
%         hand06{i} = 3;
%     end
% end
% hand06 = cell2mat(hand06);
% hand06 = hand06';
% 
% 
fid = fopen(fullfile(wkdir,'SubjDemography','nspSubjID-1.txt'));
C = textscan(fid,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t\n','delimiter','\t','headerlines',1);
fclose(fid);
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


