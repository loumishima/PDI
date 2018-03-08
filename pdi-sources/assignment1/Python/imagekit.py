#!/usr/bin/python

import sys

try:
   from PIL import Image,ImageStat
except Exception as e:
   print("Image libraries are not installed")
   sys.exit()


def normalize(value):
    if value < 0:
        return 0
    if value > 255:
        return 255
    return value

def invert(src):
    inv = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            r = normalize(255 - pixel[0])
            g = normalize(255 - pixel[1])
            b = normalize(255 - pixel[2])
            inv.putpixel((row,col), (r, g, b))
    return inv


def threshold(src, value):
    Y = rgbToYiq(src)
    if value < 0:
        stat = ImageStat.Stat(Y)
        value = stat.mean[0]
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = Y.getpixel((row, col))
            y = 255 if pixel[0] > value else 0
            i = pixel[1]
            q = pixel[2]
            Y.putpixel((row, col), (y, i, q))
            
    return yiqToRgb(Y).convert("L")

def channelR(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (pixel[0], 0, 0))
    return img

def channelG(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (0, pixel[1], 0))
    return img

def channelB(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (0, 0, pixel[2]))
    return img

def channelRMono(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (pixel[0], pixel[0], pixel[0]))
    return img

def channelGMono(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (pixel[1], pixel[1], pixel[1]))
    return img

def channelBMono(src):
    img = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            img.putpixel((row, col), (pixel[2], pixel[2], pixel[2]))
    return img

def multiply(src, value):
    mul = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            r = normalize(int(pixel[0] * value))
            g = normalize(int(pixel[1] * value))
            b = normalize(int(pixel[2] * value))
            mul.putpixel((row,col), (r, b, g))
    return mul

def additive(src, value):
    add = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            r = normalize(int(pixel[0] + value))
            g = normalize(int(pixel[1] + value))
            b = normalize(int(pixel[2] + value))
            add.putpixel((row,col), (r, b, g))
    return add


def rgbToYiq(src):
    yiq = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            y = int((0.299*pixel[0]) + (0.587*pixel[1]) + (0.114*pixel[2]))
            i = int((0.596*pixel[0]) - (0.275*pixel[1]) - (0.321*pixel[2]))
            q = int((0.212*pixel[0]) - (0.523*pixel[1]) + (0.311*pixel[2]))
            yiq.putpixel((row, col), (y, i, q))
    return yiq


def yiqToRgb(src):
    rgb = Image.new(src.mode, src.size)
    for row in range(0, src.size[0]):
        for col in range(0, src.size[1]):
            pixel = src.getpixel((row, col))
            r = normalize(int((1*pixel[0]) + (0.956*pixel[1]) + (0.621*pixel[2])))
            g = normalize(int((1*pixel[0]) - (0.272*pixel[1]) - (0.647*pixel[2])))
            b = normalize(int((1*pixel[0]) - (1.107*pixel[1]) + (1.704*pixel[2])))
            rgb.putpixel((row, col), (r,g,b))
    return rgb

def sobel(src):
    import math
    if src.mode != 'RGB':
        src = src.convert('RGB')
    edge = Image.new("L", src.size, None)
    img_data = src.load()
    out_data = edge.load()

    kernel_x = [[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]]
    kernel_y = [[-1, -2, -1], [0, 0, 0], [1, 2, 1]]
    kernel_size = 3
    kernel_middle = kernel_size/2

    rows, cols = src.size

    for row in xrange(rows-kernel_size):
        for col in xrange(cols-kernel_size):
            pixel_x = 0
            pixel_y = 0
            for i in xrange(kernel_size):
                for j in xrange(kernel_size):
                    val = sum(img_data[row+i,col+j])/3
                    pixel_x += kernel_x[i][j] * val
                    pixel_y += kernel_y[i][j] * val
            new_pixel = math.sqrt(pixel_x * pixel_x + pixel_y * pixel_y)
            new_pixel = int(new_pixel)
            out_data[row+kernel_middle,col+kernel_middle] = new_pixel

    return edge


def average(src, value):
    import numpy as np
    kernel = np.zeros((value,value,1))
    kernel[:,:] = 1 / float(kernel.shape[0]*kernel.shape[0])

    # Convert the PIL image to a numpy array
    image = np.array(src)
    convoluted = np.zeros(np.array(image.shape) + np.array(kernel.shape) - 1)
    for i in range(kernel.shape[0]):
        for j in range(kernel.shape[1]):
            convoluted[i:i+image.shape[0], j:j+image.shape[1]] += image * kernel[i,j]

    # Convert the numpy array to PIL Image and return it
    return Image.fromarray(convoluted.astype('uint8'))


def laplacian(src):
    import math
    if src.mode != 'RGB':
        src = src.convert('RGB')
    edge = Image.new("L", src.size, None)

    img_data = src.load()
    out_data = edge.load()

    kernel_x = [[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]]
    #kernel_x = [[1, -2, 1], [-2, 4, -2], [1, -2, 1]]
    kernel_size = 3
    kernel_middle = kernel_size/2

    rows, cols = src.size

    for row in xrange(rows-kernel_size):
        for col in xrange(cols-kernel_size):
            pixel_x = 0
            for i in xrange(kernel_size):
                for j in xrange(kernel_size):
                    val = sum(img_data[row+i,col+j])/3
                    pixel_x += kernel_x[i][j] * val
            new_pixel = int(pixel_x)
            out_data[row+kernel_middle,col+kernel_middle] = new_pixel
    return edge

def median1(src, value):
    import numpy as np
    import math
    edge = Image.new(src.mode, src.size, None)
    img_data = src.load()
    out_data = edge.load()

    kernel_size = value
    kernel_middle = kernel_size/2

    rows, cols = src.size

    for row in xrange(rows-kernel_size):
        for col in xrange(cols-kernel_size):
            pixel = [0,0,0]
            for i in xrange(kernel_size):
                for j in xrange(kernel_size):
                    pixel[0] += img_data[row+i,col+j][0]
                    pixel[1] += img_data[row+i,col+j][1]
                    pixel[2] += img_data[row+i,col+j][2]

            new_pixel = [i/kernel_size**2 for i in pixel]
            new_pixel = tuple(new_pixel)
            out_data[row+kernel_middle,col+kernel_middle] = new_pixel
    return edge

def median(src, value):
    import numpy as np
    import math
    edge = Image.new(src.mode, src.size, None)
    img_data = src.load()
    out_data = edge.load()

    kernel_size = value
    kernel_middle = kernel_size/2

    rows, cols = src.size

    for row in xrange(rows-kernel_size):
        for col in xrange(cols-kernel_size):
            neighbors = []
            for i in xrange(kernel_size):
                for j in xrange(kernel_size):
                     neighbors.append(img_data[row+i,col+j])

            nlen = len(neighbors)
            if nlen:
                red = [neighbors[i][0] for i in range(nlen)]
                green = [neighbors[i][1] for i in range(nlen)]
                blue = [neighbors[i][2] for i in range(nlen)]

                for i in [red, green, blue]:
                    i.sort()

                if nlen % 2:
                    r = red[len(red)/2]
                    g = green[len(green)/2]
                    b = blue[len(blue)/2]
                else:
                    r = (red[len(red)/2] + red[len(red)/2-1])/2
                    g = (green[len(green)/2] + green[len(green)/2-1])/2
                    b =  p.blue = (blue[len(blue)/2] + blue[len(blue)/2-1])/2
                out_data[row+kernel_middle,col+kernel_middle] = (r, g, b)
    return edge

if __name__ == '__main__':

    import argparse

    parser = argparse.ArgumentParser(description='Image manipulation filters')

    parser.add_argument('-v','--version',
        action='version',
        version='%(prog)s 0.1')

    parser.add_argument('--show',
        help='Visualize image file',
        action='store_true')

    parser.add_argument('-i', '--input',
        help='Input file name')

    parser.add_argument('-o','--output',
        help='Output file name')

    parser.add_argument('--invert',
        help='Invert filter',
        action='store_true')

    parser.add_argument('--rgbtoyiq',
        help='Converts from YIQ color system to RGB color system',
        action='store_true')

    parser.add_argument('--yiqtorgb',
        help='Converts from RGB color system to YIQ color system',
        action='store_true')

    parser.add_argument('--redchannel',
        help='Display only the red channel of the image',
        action='store_true')

    parser.add_argument('--bluechannel',
        help='Display only the blue channel of the image',
        action='store_true')

    parser.add_argument('--greenchannel',
        help='Display only the green channel of the image',
        action='store_true')

    parser.add_argument('--monoredchannel',
        help='Display only the monochrome red channel of the image',
        action='store_true')

    parser.add_argument('--monobluechannel',
        help='Display only the monochrome blue channel of the image',
        action='store_true')

    parser.add_argument('--monogreenchannel',
        help='Display only the monochrome green channel of the image',
        action='store_true')

    parser.add_argument('--multiply',
        help='Multiplicative brightness control',
        type=float)

    parser.add_argument('--additive',
        help='Additive brightness control',
        type=int)

    parser.add_argument('--threshold',
        help='Threshold over channel Y',
        type=int)

    parser.add_argument('--sobel',
        help='Sobel edge detection filter',
        action='store_true')

    parser.add_argument('--laplacian',
        help='Laplacian edge detection filter',
        action='store_true')

    parser.add_argument('--average',
        help='Average filter',
        type=int)

    parser.add_argument('--median',
        help='Median filter',
        type=int)

    args = parser.parse_args()

    if args.input:

        if args.show:
            try:
                fin = Image.open(args.input)
                fin.show()
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.median:
            try:
                fin = Image.open(args.input)
                fou = median(fin, args.median)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.laplacian:
            try:
                fin = Image.open(args.input)
                fou = laplacian(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.average:
            try:
                fin = Image.open(args.input)
                fou = average(fin, args.average)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.invert:
            try:
                fin = Image.open(args.input)
                fou = invert(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.multiply:
            try:
                fin = Image.open(args.input)
                fou = multiply(fin, args.multiply)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.additive:
            try:
                fin = Image.open(args.input)
                fou = additive(fin, args.additive)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.rgbtoyiq:
            try:
                fin = Image.open(args.input)
                fou = rgbToYiq(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to ead/write to disk.\n")

        if args.yiqtorgb:
            try:
                fin = Image.open(args.input)
                fou = yiqToRgb(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.redchannel:
            try:
                fin = Image.open(args.input)
                fou = channelR(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.bluechannel:
            try:
                fin = Image.open(args.input)
                fou = channelB(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.greenchannel:
            try:
                fin = Image.open(args.input)
                fou = channelG(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.monoredchannel:
            try:
                fin = Image.open(args.input)
                fou = channelRMono(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.monobluechannel:
            try:
                fin = Image.open(args.input)
                fou = channelBMono(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.monogreenchannel:
            try:
                fin = Image.open(args.input)
                fou = channelGMono(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.threshold:
            try:
                fin = Image.open(args.input)
                fou = threshold(fin, args.threshold)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk.\n")

        if args.sobel:
            try:
                fin = Image.open(args.input)
                fou = sobel(fin)
                fou.show()
                if args.output:
                    fou.save(args.output)
            except IOError:
                print("IOError, checks whether the image exists on the disk " \
                    "or if it has the necessary permission to read/write to disk\n.")

