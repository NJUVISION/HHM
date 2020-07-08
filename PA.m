function output =  PA(map,input)
%PA 此处显示有关此函数的摘要
%   此处显示详细说明
im = input;
[h,w,~] = size(im);
for c = 1:3
    for i = 1:h
       for j = 1:w
           im(i,j,c) = map(c,im(i,j,c)+1 ) -1; 
       end
    end
end
output=im;
end

