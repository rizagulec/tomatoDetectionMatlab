function [veriSeti] =superpixel2ValidX(superImage,exrIsAdded,exgrIsAdded)
     %aşağıdaki kodda channel başına domates/arkaplan ayrımı yapılmaktadır.
   veriSeti=double(0);
     %%%%%%%%%%%%%%%%%%%%%%%
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
    
    
    exgr=3*g-2.4*r-b;
    
    %vari=(g-r)/(g+r-b);
    %gli=(2*g-b-r)/(2*g+b+r);
    
    r=superImage(:,:,1);  % r => hafızada yer kaplamasın int' e geri dönsün 
    g=superImage(:,:,2);
    b=superImage(:,:,3);
    

    % Önemli chanellar aşağıda kayıt edilmektedir.
   
    tempSample=r;
    tempSample=cat(2,tempSample,g);
    tempSample=cat(2,tempSample,b);
    tempSample=cat(2,tempSample,h);
    tempSample=cat(2,tempSample,s);
   % tempSample=cat(2,tempSample,vDomat);
   % tempSample=cat(2,tempSample,lDomat);
    tempSample=cat(2,tempSample,a);
    tempSample=cat(2,tempSample,bLab);
    tempSample=cat(2,tempSample,cb);
    if(exrIsAdded)
        tempSample=cat(2,tempSample,exr);
    end
    if(exgrIsAdded)
        tempSample=cat(2,tempSample,exgr);
    end
    veriSeti=tempSample;
    
end