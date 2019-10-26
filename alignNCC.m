function retVal = alignNCC(img1, img2)

offset = [0,0];
c = normxcorr2(img1,img2);
[topY, topX] = find(c==max(c(:)));
offset(1) = topY - size(img1,1);
offset(2) = topX - size(img1,2);

retVal = circshift(img1,offset);

end



