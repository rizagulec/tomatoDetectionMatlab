function [BW]=superPixel2Image(superImage,YPred,image,idxStore)
    %imshow(image);
    BW=im2gray(image);
  
    for i=1:size(YPred,1)
        k=255*double(YPred(i));
        BW(idxStore{i})=k;
        
    end
    imshow(BW);
  
end