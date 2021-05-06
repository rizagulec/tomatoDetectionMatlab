function [pixelSample]= kanallaraBol(superImage,superLabel)
    exrIsAdded=1;
    exgrIsAdded=1;
    veriSeti=0;
    
    r=superImage(:,:,1);  % r => red channel
    g=superImage(:,:,2);
    b=superImage(:,:,3);
    
    %%%%%%%%%%%%%%%%%%%%%

    hsv=rgb2hsv(superImage);
    
    h=hsv(:,:,1);
    s=hsv(:,:,2);
    v=hsv(:,:,3);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    lab=rgb2lab(superImage);
    
    l=lab(:,:,1);
    a=lab(:,:,2);
    bLab=lab(:,:,3);

 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    ycbcr=rgb2ycbcr(superImage);

    y=ycbcr(:,:,1);
    cb=ycbcr(:,:,2);
    cr=ycbcr(:,:,3);

%%%%%%%%%%%%%%%%%%%%%%
    g=double(g);
    r=double(r);
    b=double(b);
    %ndi=(g-r)/(g+r);
    %exg=2*g-r-b;
    exr=1.4*r-g;
    exrDomat=exr(superLabel==1);
    exrArka=exr(superLabel==0);
   
    exgr=3*g-2.4*r-b;
    exgrDomat=exgr(superLabel==1);
    exgrArka=exgr(superLabel==0);


%%%%%%%%%%%%%%%%%%%%%%%
%%%%veri seti oluştur

    tempSample=double(0);
    tempSample=double(r);
    tempSample=cat(2,tempSample,double(g));
    tempSample=cat(2,tempSample,double(b));
    tempSample=cat(2,tempSample,double(h));
    tempSample=cat(2,tempSample,double(s));
   % tempSample=cat(2,tempSample,vDomat);
   % tempSample=cat(2,tempSample,lDomat);
    tempSample=cat(2,tempSample,double(a));
    tempSample=cat(2,tempSample,double(bLab));
    tempSample=cat(2,tempSample,double(cb));
    if(exrIsAdded)
        tempSample=cat(2,tempSample,double(exr));
    end
    if(exgrIsAdded)
        tempSample=cat(2,tempSample,double(exgr));
    end
    
    if(veriSeti==0)
        veriSeti=tempSample;
    else
        
        veriSeti=cat(1,veriSeti,tempSample);
       
        
    end
    
    pixelSample=veriSeti;
end