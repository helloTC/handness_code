% nspwritebis.m
% �ó�����Ϊ���޸�BIS_06��BIS_08�����ļ���ʹ֮scaleid���nspid��
% ���иó���֮ǰ����������addhandnessinfo.m�Եõ�id_bis6��id_bis8�����������õ�������
% �޸�·��ֱ�����о��ܵõ���nspid����scaleid����ļ���


rawdir = 'E:\project\BNU_2015\behavior data\tables\handness\origin' ;

idbis6_cell = cell(length(id_bis6),1);
idbis8_cell = cell(length(id_bis8),1);
id_rawa = 'S0000';
for i = 1:length(id_bis6)
    id_rawa(end-length(num2str(id_bis6(i)))+1:end) = num2str(id_bis6(i));
    idbis6_cell{i} = id_rawa;
    id_rawa = 'S0000';
end
for i = 1:length(id_bis8)
    id_rawa(end-length(num2str(id_bis8(i)))+1:end) = num2str(id_bis8(i));
    idbis8_cell{i} = id_rawa;
    id_rawa = 'S0000';
end


xlswrite(fullfile(rawdir,'BIS_06.xlsx'),{'NSPID'},1,'B1');
xlswrite(fullfile(rawdir,'BIS_06.xlsx'),idbis6_cell,1,'B2');
xlswrite(fullfile(rawdir,'BIS_08.xlsx'),{'NSPID'},1,'A1');
xlswrite(fullfile(rawdir,'BIS_08.xlsx'),idbis8_cell,1,'A2');