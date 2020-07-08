# Array camera color correction
main.m   主函数,输入/6to7,演示两张图像的校正

AHMpro.m    建模过程，input:两个重叠区域，output:map,(1X3X256)

PA.m   校正过程， input: map, 待校正图片， output:校正后图片

Th.m   求阈值过程， input: 任意图片   output: 阈值Th(范围[0,255])

transform_ave: 输入/data,计算NxN个map,并根据平均map校正所有图像

/data:N 张图像以及它们的重叠区域