clear all;
%%
[user, sys] = memory ;
mStart = user.MemUsedMATLAB ;


data_path = 'data';
result_path = 'result_overlap';
mkdir(result_path);
N =10 ;

for i =1:N
    mkdir(fullfile(result_path,num2str(i)));
    for j = 1:N-1
        tmp = imread(fullfile(data_path,[num2str(j),'to',num2str(j+1),'.png']));
        imwrite(tmp,fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j+1),'.png']));
    end
    for j =2:N
        tmp = imread(fullfile(data_path,[num2str(j),'to',num2str(j-1),'.png']));
        imwrite(tmp,fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j-1),'.png']));
    end
end
%%
time=zeros(100,100);
timeoverlap=zeros(100,100);
maps = cell(N);
for i=1:10
    maps{i,i} = [1:256;1:256;1:256];
    % å‘å‰å˜æ¢
    for j = i-1:-1:1
        tgt_path = fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j+1),'.png']);
        src_path = fullfile(result_path,num2str(i),[num2str(j+1),'to',num2str(j),'.png']);
        tgt = imread(tgt_path);
        src = imread(src_path);
       
        map = HHM(tgt,src);%% mapéœ?è¦ä¿å­?
        feature('memstats')
       
        %time(i,j)=toc;
        maps{i,j} = map;
        %
        if j >1
            input_path = fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j-1),'.png']);
            input = imread(input_path);
           
            output = PA(map,input);
           
           % timeoverlap(i,j)=toc;
            imwrite(output,input_path);
        end
    end
    % å‘åŽå˜æ¢
    for j = i+1:N
        tgt_path = fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j-1),'.png']);
        src_path = fullfile(result_path,num2str(i),[num2str(j-1),'to',num2str(j),'.png']);
        tgt = imread(tgt_path);
        src = imread(src_path);
       
        map = HHM(tgt,src);%% mapéœ?è¦ä¿å­?
       
       % time(i,j)=toc;
        maps{i,j} = map; %i:labelç›¸æœº, j:è¦çŸ«æ­£çš„ç›¸æœº
        %
        if j <N
            input_path = fullfile(result_path,num2str(i),[num2str(j),'to',num2str(j+1),'.png']);
            input = imread(input_path);
         
            output = PA(map,input);
           
          %  timeoverlap(i,j)=toc;
            imwrite(output,input_path);   mn   
        end
    end
end
%%
aver_map = cell(N,1);
tic;
for j =1:N
    tmp = zeros(size(maps{1,j}));
    for i=1:N
        tmp = 1/N * maps{i,j}+tmp;       
    end
    aver_map{j} = tmp;
end
toc

[user, sys] = memory ;
mtotal = user.MemUsedMATLAB - mStart
%% 
% % è¾“å‡ºæœ?ç»ˆç»“æž?
% output_path = 'output_ave';
% mkdir(output_path);
% for i =1:N
%     tmp = imread(fullfile(data_path,[num2str(i),'.png']));
%     output = PA(aver_map{i},tmp);
%     imwrite(output,fullfile(output_path,[num2str(i),'.png']));   
% end

%%
%local map colorcorrection
% for i=1:N
%     output_path = ['output_',num2str(i)];
%     mkdir(output_path);
%     for j =1:N
%         tmp = imread(fullfile(data_path,[num2str(j),'.png']));
%         tic;
%         output = PA(maps{i,j},tmp);
%         toc
%         imwrite(output,fullfile(output_path,[num2str(j),'.png']));   
%     end
% end
