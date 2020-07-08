imsrc=imread('6to7/6to7.png');
imtgt=imread('6to7/7to6.png');
im=imread('6to7/7.png');
[map]=AHMpro(imtgt,imsrc);
correct=PA(map,im);
imwrite(correct,'6to7/output7test.png');