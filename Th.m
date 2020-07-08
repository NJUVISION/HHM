function output = Th(na,pixel_num)
%TH 输入直方图和总像素数，输出对直方图从小到大排序后，刚好达到总像素值5%的像素值对应的直方图大小.
B = zeros(3,256);
Sa = zeros(3,256);
threshold = zeros(1,3);
for c=1:3
    [B(c,:),index]=sortrows(na(c,:)');
    Sa(c,1) = B(c,1);
    for n = 2:256    
        Sa(c,n) = Sa(c,n-1) + B(c,n);    
    end
    number=1;
    while Sa(c,number)<pixel_num/20
        number = number+1;
    end
    threshold(c)=na(c,index(number));
    output=threshold;
end

