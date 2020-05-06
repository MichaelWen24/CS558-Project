from PIL import Image
import numpy as np
import time
import skimage.color
from skimage.segmentation import mark_boundaries, find_boundaries
from skimage.segmentation import slic
import imageio
from SNIC import snic

# load image
image = np.array(Image.open('project4/white-tower.png'))
image1 = np.array(Image.open('project4/wt_slic.png'))
lab_image = skimage.color.rgb2lab(image)

# SNIC parameters
grid_of_x = 10
grid_of_y = 10
compactness = 40
iteration = 10

t1 = time.time()
[label_map_snic, centroids_snic] = snic(lab_image, grid_of_x, grid_of_y, compactness,)
t2 = time.time()
label_map_snic = label_map_snic.astype(int)
image_seg_snic = mark_boundaries(image, np.array(label_map_snic))
bd_snic = find_boundaries(np.array(label_map_snic)) *1
# img_uint8 = image_seg_snic.astype(np.uint8)
imageio.imwrite('tower_snic.png', image_seg_snic)
print('SNIC cost :', t2-t1)

#SLIC used skimage
segments = slic(image, n_segments = 100, compactness = 40)
t3 = time.time()
slic_skimage = mark_boundaries(image, segments)
bd_slic_skimage = find_boundaries(np.array(segments)) *1
# img1_uint8 = slic_skimage.astype(np.uint8)
t4 = time.time()
imageio.imwrite('tower_originalslic.png', slic_skimage)
print('Original SLIC cost:', t4-t3)