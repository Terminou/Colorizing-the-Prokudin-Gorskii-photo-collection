function retVal = crop(img, percentage)

[width, height] = size(img);
retVal = img(round(percentage * width):width-round(percentage * width), round(percentage * height):height-round(percentage * height));

end