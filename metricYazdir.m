function[metric]=metricYazdir(preds,labels)
    %%%%%Başarı oranları
 TP=0;FP=0;TN=0;FN=0;
      for i=1:size(labels,1)%%%%%trainY veya testY !!!!
        if(preds(i)==1 & labels(i)==1);%%%%%trainY veya testY !!!!
            TP=TP+1;
        elseif(labels(i)==0 & preds(i)==1);%%%%%rainY veya testY !!!!
            FP=FP+1;
        elseif(preds(i)==0 & labels(i)==0);%%%%%trainY veya testY !!!!
            TN=TN+1;
        else
            FN=FN+1;
        end
        
      end
     
    precision=TP/(TP+FP)
    recall=TP/(TP+FN)
    fScore=2*TP/(2*TP+FP+FN)
   
end