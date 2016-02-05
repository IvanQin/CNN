%function [train_x train_y test_x test_y]=CIFAR10_P()
%% load training set
ps='../cifar-10-batches-mat/data_batch_';
for i=1:5
   s=[ps num2str(i) '.mat'];
   load(s);
   if i==1
      train_x=data;
      train_y=labels;
   else train_x=[train_x;data];
        train_y=[train_y;labels];
   end
   
end
%% load test set
load('../cifar-10-batches-mat/test_batch.mat');

test_x=data;
test_y=labels;
%% transform RGB to Grey in training set
tmp_x=zeros(size(train_x,1),1024);
for i=1:size(train_x,1)
    for j=1:32*32
        R=train_x(i,j);
        G=train_x(i,j+1024);
        B=train_x(i,j+2048);
        %tmp_x(i,j)=(R*30+G*59+B*11)/100;
        tmp_x(i,j)=(R*0.299+G*0.587+B*0.114);
    end
end
train_x=uint8(tmp_x);
%% transform RGB to Grey in test set
tmp_x=zeros(size(test_x,1),1024);
for i=1:size(test_x,1)
    for j=1:32*32
        R=test_x(i,j);
        G=test_x(i,j+1024);
        B=test_x(i,j+2048);
        tmp_x(i,j)=(R*0.299+G*0.587+B*0.114);
    end
end
test_x=uint8(tmp_x);

%end


 