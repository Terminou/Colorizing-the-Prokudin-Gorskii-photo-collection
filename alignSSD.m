function retVal = alignSSD(img1, img2)

min = inf;
for i = -15:15
    for j = -15:15
        temp = circshift(img1,[i,j]);
        ssd = sum(sum((img2-temp).^2));
        if min > ssd
            min = ssd;
            retVal = [i,j];
        end
    end
end

end