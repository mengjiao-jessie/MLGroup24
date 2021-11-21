%cross validation
function [RMSEtrain,RMSEtest]=kCrossV(traindata,labels,K)
    RMSEtrain=0;
    RMSEtest=0;
    for i = 1:K
        Knum=size(traindata,1)/K;
        vaildset=traindata(1+(i-1)*Knum:i*Knum,:);
        vaildlabel=labels(1+(i-1)*Knum:i*Knum,:);
        if i==1
            trainset=traindata(1+i*Knum:end,:);
            trainlabel=labels(1+i*Knum:end,:);
        elseif i==10
            trainset=traindata(1:(i-1)*Knum,:);
            trainlabel=labels(1:(i-1)*Knum,:);
        else
            trainset=traindata([1:(i-1)*Knum i*Knum+1:end],:);
            trainlabel=labels([1:(i-1)*Knum i*Knum+1:end],:);
        end

        fprintf('==Cross Validation: %d\n', i);
        tree = createTree(trainset,trainlabel, tolS, tolN, feature_used);
        %% trainset
        Dif1= predict(tree,trainset)- trainlabel;
        m= find(isnan(Dif1));
        Dif1(m,:)=[];
        RMSE1 = sqrt(sum(Dif1.*Dif1));
        RMSEtrain=RMSEtrain+RMSE1;
        fprintf('RMSE on TrainDataSet %f\n', RMSE1);


        %testset
        Dif2=predict(tree,vaildset)- vaildlabel;
        Dif2(m,:)=[];
        RMSE2 = sqrt(sum(Dif2.*Dif2));
        RMSETest=RMSEtrain+RMSE2;
        fprintf('RMSE on testDataSet %f\n', RMSE2);

    end


end
