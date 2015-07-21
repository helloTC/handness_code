% nspwritebis.m
% 该程序是为了修改BIS_06和BIS_08两个文件，使之scaleid变成nspid。
% 运行该程序之前，请先运行addhandnessinfo.m以得到id_bis6和id_bis8两个变量。得到变量后，
% 修改路径直接运行就能得到用nspid覆盖scaleid后的文件。


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