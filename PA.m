function output =  PA(map,input)
%PA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

