# Array camera color correction
main.m   demo function of two images color correction, input:/6to7

HHM.m    input:two overlaps, output:map,(1X3X256)

PA.m    input: map, image to be corrected, output:image after correction

Th.m   find threshold, input: an image   output: threshold Th([0,255])

transform_ave: input: /data, calculate NxN maps, and correcte all images using average_map

/data:N images and their overlaps, example data is in data1.rar and data2.rar
