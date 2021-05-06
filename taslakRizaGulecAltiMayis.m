exrIsAdded=1;
exgrIsAdded=1;
veriSeti=0;
overSampSay=1;
downSampSay=1;


%32 adet image için
for i=1:32
    breakpointSatiridir=453452;
    
    image=images {i,1};
    mask=images {i,2} ;
    mask=im2uint8(mask);
    mask=mask/255; %maskı 0 ve 1 arasına normalize et
    %domates=image.*mask; %sadece domates görselleri
    [superImage,superLabel,idxStore,outputImage]=superpixelYap(image,mask);
    imshow(outputImage)
    datasetSuperImages{i}=superImage;
    datasetSuperLabels{i}=superLabel;
    datasetIdxStores{i}=idxStore;
    datasetImshow{i}=outputImage;
    %aşağıdaki kodda channel başına domates/arkaplan ayrımı yapılmaktadır.
    %%%%%%%%%%%%%%%%%%%%%%%
    r=superImage(:,:,1);  % r => red channel
    rDomat=r(superLabel==1); %rDomat => red channel' daki domates pikseller
    rArka=r(superLabel==0); %rArka => red channel' daki arka plan pikseller
    
    g=superImage(:,:,2);
    gDomat=g(superLabel==1);
    gArka=g(superLabel==0);
    
    b=superImage(:,:,3);
    bDomat=b(superLabel==1);
    bArka=b(superLabel==0);


 %%%%%%%%%%%%%%%%%%%%%

    hsv=rgb2hsv(superImage);
    
    h=hsv(:,:,1);
    hDomat=h(superLabel==1);
    hArka=h(superLabel==0);
    
    s=hsv(:,:,2);
    sDomat=s(superLabel==1);
    sArka=s(superLabel==0);
    
    v=hsv(:,:,3);
    vDomat=v(superLabel==1);
    vArka=v(superLabel==0);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    lab=rgb2lab(superImage);

    
    l=lab(:,:,1);
    lDomat=l(superLabel==1);
    lArka=l(superLabel==0);
    
    a=lab(:,:,2);
    aDomat=a(superLabel==1);
    aArka=a(superLabel==0);
    
    bLab=lab(:,:,3);
    bLabDomat=bLab(superLabel==1);
    bLabArka=bLab(superLabel==0);

 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    ycbcr=rgb2ycbcr(superImage);

    y=ycbcr(:,:,1);
    yDomat=y(superLabel==1);
    yArka=y(superLabel==0);
    
    cb=ycbcr(:,:,2);
    cbDomat=cb(superLabel==1);
    cbArka=cb(superLabel==0);
    
    cr=ycbcr(:,:,3);
    crDomat=cr(superLabel==1);
    crArka=cr(superLabel==0);

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
    %vari=(g-r)/(g+r-b);
    %gli=(2*g-b-r)/(2*g+b+r);
 
    % Önemli chanellar aşağıda kayıt edilmektedir.
    tempSample=double(0);
    tempSample=double(rDomat);
    tempSample=cat(2,tempSample,double(gDomat));
    tempSample=cat(2,tempSample,double(bDomat));
    tempSample=cat(2,tempSample,double(hDomat));
    tempSample=cat(2,tempSample,double(sDomat));
   % tempSample=cat(2,tempSample,vDomat);
   % tempSample=cat(2,tempSample,lDomat);
    tempSample=cat(2,tempSample,double(aDomat));
    tempSample=cat(2,tempSample,double(bLabDomat));
    tempSample=cat(2,tempSample,double(cbDomat));
    if(exrIsAdded)
        tempSample=cat(2,tempSample,double(exrDomat));
    end
    if(exgrIsAdded)
        tempSample=cat(2,tempSample,double(exgrDomat));
    end
    labels=ones(size(tempSample,1),1,'double');
    tempSample=cat(2,tempSample,labels); %labellar
   
    if(veriSeti==0)
        veriSeti=tempSample;
    else
        for index=1:overSampSay;
            veriSeti=cat(1,veriSeti,tempSample);
        end
        
    end
    
    
      %--------------------    
    if(1)%%kodu değiştirdim
       tempSample=double(rArka);
       tempSample=cat(2,tempSample,double(gArka));
       tempSample=cat(2,tempSample,double(bArka));
       tempSample=cat(2,tempSample,double(hArka));
       tempSample=cat(2,tempSample,double(sArka));
   % tempSample=cat(2,tempSample,vArka);
   % tempSample=cat(2,tempSample,lArka);
       tempSample=cat(2,tempSample,double(aArka));
       tempSample=cat(2,tempSample,double(bLabArka));
       tempSample=cat(2,tempSample,double(cbArka));
    if(exrIsAdded)
        tempSample=cat(2,tempSample,double(exrArka));
    end
    if(exgrIsAdded)
        tempSample=cat(2,tempSample,double(exgrArka));
    end
    labels=zeros(size(tempSample,1),1,'double');
    tempSample=cat(2,tempSample,labels); %labellar
    
    if(veriSeti==0)
        veriSeti=tempSample;
    else
        ra=randperm(size(tempSample,1));
        tempSample(ra,:)=tempSample;
        tempSample=downsample(tempSample,downSampSay)
        veriSeti=cat(1,veriSeti,tempSample);
    end 
  end
    
    
    superImage;
    whos veriSeti;
    i
end
    ra=randperm(size(veriSeti,1));
    veriSeti(ra,:)=veriSeti;

breakpointSatiridir=2453656,
sampleSayisi=size(veriSeti);
sampleSayisi=sampleSayisi(1,1);
sampleSayisi

featureSay=size(veriSeti,2);
%veri setinin ilk %70ini train seti olarak kullan
trainX=veriSeti(1:round(sampleSayisi*0.70),1:(featureSay-1));
trainY=veriSeti(1:round(sampleSayisi*0.70),featureSay);


%veri setinin son %30unu test seti olarak kullan
testX=veriSeti(round(sampleSayisi*0.7)+1:sampleSayisi,1:(featureSay-1));
testY=veriSeti(round(sampleSayisi*0.7)+1:sampleSayisi,featureSay);


%classifier=fitcsvm(trainX,trainY);

%%%%%%%%%%%%%%%%%
%Train metric hesaplama
'train ====>'
YPred = predict(classifier,double(trainX));

'test ====>'
YPred = predict(classifier,double(trainX));

%%%%%%%%%%%%%%%%%%%
%%validation

testX=veriSeti(:,1:(10));
testY=veriSeti(:,11);

shveri=veriSeti;
%ra=randperm(size(veriSeti,1));
%shveri(ra,:)=veriSeti;
testX=shveri(1:15,1:(10));
testY=shveri(1:15,11);

YPred = predict(classifier,double(testX));
metricYazdir(testY,YPred);
%%Bütün görselleri Spixel yap,test et, sonuçları kaydet
allSuperImageYCombine={};
for i=1:1
    image=images {i,1};
    mask=images {i,2} ;
    mask=im2uint8(mask);
    mask=mask/255;
    [superImage,superLabel,idxStore,outputImage]=superpixelYap(image,mask);
    imshow(outputImage)
    superImageY=[];
    for j=1:numel(superLabel)
        pixelSample = kanallaraBol(superImage,superLabel);
        %ra=randperm(size(pixelSample,1));
        %pixelSample(ra,:)=pixelSample();
        YPred = predict(classifier,pixelSample(:,1:10));
        superImageY=cat(1,YPred);
    end
    allSuperImageYCombine{i}=superImageY;
    
    [BW]=superPixel2Image(superImage,superImageY,image,idxStore);
end