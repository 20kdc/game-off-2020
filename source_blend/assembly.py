#!/usr/bin/env python3

import PIL
import PIL.Image

images = []
image_size = None
for i in range(72):
	img = PIL.Image.open("assembly/{0:04d}.png".format(i + 1))
	images.append(img)
	image_size = img.size

full_image_size = (image_size[0] * 9, image_size[1] * 8)
print(full_image_size)

full = PIL.Image.new("RGBA", full_image_size)
idx = 0
for i in range(8):
	for j in range(9):
		full.paste(images[idx], (j * image_size[0], i * image_size[1]))
		idx += 1
full.save("assembly.png")
