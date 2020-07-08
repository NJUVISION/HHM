function [map] = AHMpro(im_tgt,im_src)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    [H,W,~] = size(im_src);
    pixel_num = H*W; 
    im_tgt = imresize(im_tgt,[H W]);
    x = 1:256;
    %%
    %get pixel number
    na = zeros(3,256);  %每个亮度的像素数  a是tgt,  b是src
    Sa = zeros(3,256);  %积分
    nb = zeros(3,256);
    Sb = zeros(3,256);
    for c = 1:3
        [na(c,:),~] = imhist(im_tgt(:,:,c));         
        [nb(c,:),~] = imhist(im_src(:,:,c));
    end
    
    
    Sa(:,1) = na(:,1);
    Sb(:,1) = nb(:,1);
    for n = 2:256    
        Sa(:,n) = Sa(:,n-1) + na(:,n);
        Sb(:,n) = Sb(:,n-1) + nb(:,n);
    end
    %%
    %build map
    map = [x;x;x];
    index = ones(3,256);   %index 记录累计直方图小于阈值的区间，用0表示，否则index为1
    threshold_a = Th(na,pixel_num);
    threshold_b = Th(nb,pixel_num);
    for c = 1:3
        gradient=zeros(c,257);   %记录有几个端点值
        srcMax = max(max(im_src(:,:,c)))+1;
        srcMin = min(min(im_src(:,:,c)))+1;
        for a = 1:256
            b = 1;
            while Sa(c,a) > Sb(c,b)
                b = b+1;
                if b>srcMax
                    b=srcMax;       %改成src最大值
                    break
                end
            end                
            if b<srcMin
                b=srcMin;
            end
            map(c,a) = b;
            if na(c,a)<threshold_a(c)
                map(c,a) = nan;
                index(c,a)=0;
            end
            if nb(c,b)<threshold_b(c)
                map(c,a) = nan;
                index(c,a)=0;
            end
        end
        map(c,1)=srcMin;  %设定端点值
        map(c,256)=srcMax;
        index(c,1)=1;     %标记0，256两个点为已知点
        index(c,256)=1;
    end
    gradient(:,2:256) = index(:,2:256)-index(:,1:255);
    gradient(:,1) = 0;
    region = zeros(3,20,2);   %(通道，空缺区域序号，开始/结束）
    XX = zeros(3,20,2); %(通道，空缺序号，实线上三个点横坐标）
    YY = zeros(3,20,2); %(通道，空缺序号，三个点纵坐标）
    for c=1:3
        n_re = 0;
        for a = 1:256
            if gradient(c,a)==-1
                n_re = n_re+1;
                region(c,n_re,1)=a;    
            elseif gradient(c,a)==1
                region(c,n_re,2)=a-1;           
            end
        end
        for num = 1:n_re
            XX(c,num,1)=region(c,num,1)-1;
            YY(c,num,1)=map(c,XX(c,num,1));
            XX(c,num,2)=region(c,num,2)+1;
            YY(c,num,2)=map(c,XX(c,num,2));
            p = polyfit(XX(c,num,:),YY(c,num,:),1);
            for a=region(c,num,1):region(c,num,2)
                map(c,a)=polyval(p,a);
            end
        end
    end
    %%
    %show map
    x = 1:256;
    map(1,:) = smooth(map(1,x),15);
    map(2,:) = smooth(map(2,x),15);
    map(3,:) = smooth(map(3,x),15);
end

