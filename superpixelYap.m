function [superImage,superLabel,idxStore,outputImage]=superpixelYap(image,mask)
   %%%%%%%%%%%%%%%%%%
    %superImagee çevirme ve etiketleme
    
    A = image;
    idxStore={};
    [L,N] = superpixels(A,300);

    
    BW = boundarymask(L);
%imshow(imoverlay(A,BW,'cyan'),'InitialMagnification',67)

    outputImage = zeros(size(A),'like',A);
    idx = label2idx(L);
    numRows = size(A,1);
    numCols = size(A,2);
    
    superLabel=zeros(N,1);
    superImage=zeros(N,1);
    rsuperImage=zeros(N,1);
    gsuperImage=zeros(N,1);
    bsuperImage=zeros(N,1);
    for labelVal = 1:N
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        outputImage(redIdx) = mean(A(redIdx));
        outputImage(greenIdx) = mean(A(greenIdx));
        outputImage(blueIdx) = mean(A(blueIdx));
        
        rsuperImage(labelVal)=mean(A(redIdx));
        gsuperImage(labelVal)=mean(A(greenIdx));
        bsuperImage(labelVal)=mean(A(blueIdx));
        
        
        
        
        idxStore{labelVal}=redIdx;
     
        
        tempSuperLabel=(mask(redIdx)==1); %etiketleme
        superLabel(labelVal)=round(mean(tempSuperLabel(:))); %etiketleme
    end

        
    superImage=cat(3,rsuperImage,gsuperImage,bsuperImage);   
end
