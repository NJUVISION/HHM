# Array camera color correction
main.m   demo function of two images color correction, input:/6to7

HHM.m    input:two overlaps, output:map,(1X3X256)

PA.m    input: map, image to be corrected, output:image after correction

Th.m   find threshode, input: an image   output: threshode Th([0,255])

transform_ave: 输入/data,计算NxN个map,并根据平均map校正所有图像

/data:N 张图像以及它们的重叠区域 示例数据存储在data1.rar 和data2.rar
