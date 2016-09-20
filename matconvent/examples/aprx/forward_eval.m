% % function [ y ] = forward_eval( net, x )
% %UNTITLED2 Summary of this function goes here
% %   Detailed explanation goes here
% 
% 
% % max(reshape(abs(x1),numel(x1),1))
% 
% 
% %%%%%%%%%%% setup vl_nn function%%%%%%%%%%%%%%%
% addpath matlab;
% vl_setupnn();
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%% prepare image and weight data %%%%%%%%%%%%%%%%
load('E:\Matlab\matconvnet\data\cifar-lenet\imdb.mat');
load('E:\Matlab\matconvnet\data\cifar-lenet\net-epoch-45.mat');
% load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\aprx\image_test.mat');
% load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\cifar-lenet\imdb.mat');
% load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\cifar-lenet\net-epoch-45.mat');
% 
% image_test = images.data(:,:,:,50001:60000);
% label_test = images.labels(1,50001:60000);
% label_test = int(label_test);




% global ti total tz threshold;

% image_test=single(reshape(data',32,32,3,10000));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% layer1 conv1
% x2 = vl_nnconv(x1, net.layers{1}.weights{1}, net.layers{1}.weights{2}, 'stride', 1, 'pad', 2);
% loop_cnt = 1;
% % % parfor th_i = 1:8    %%%% for parallel simulation
%     image_test = images.data(:,:,:,50001+1000*(th_i-1):50000+1000*(th_i));
%     label_test = images.labels(1,50001+1000*(th_i-1):50000+1000*(th_i));
    image_test = images.data(:,:,:,50001:60000);
    label_test = images.labels(1,50001:60000);
    label_test = uint8(label_test);
    ti=[0 0 0 0 0];
    total=[0 0 0 0 0]; 
    % total=[1 1 1 1 1]; 
    tz=[0 0 0 0 0];
    rate_zero=[0 0 0 0 0 0];
    rate_near_zero=[0 0 0 0 0 0];
    err_rate=0;
     threshold = -1 ;
%    threshold = 2^(th_i-6);

    label = [];

    for i = 1 : size(image_test,4)
    %  for i = 1 : 10
        x1 = image_test(:,:,:,i);
    
        [x2, total(1), ti(1), tz(1)] = nnconv(x1, net.layers{1}.weights{1}, net.layers{1}.weights{2}, 1, 2, threshold);

        % layer2 pool1
        x3 = vl_nnpool(x2, [3 3], 'stride', 2, 'pad', [0 1 0 1], 'method', 'max');

        % layer3 relu1
        x4 = vl_nnrelu(x3);

        % layer4 conv2
        % x5 = vl_nnconv(x4,net.layers{4}.weights{1},net.layers{4}.weights{2}, 'stride', 1, 'pad', 2);
        [x5, total(2), ti(2), tz(2)] = nnconv(x4,net.layers{4}.weights{1},net.layers{4}.weights{2}, 1, 2, threshold);

        % layer5 relu2
        x6 = vl_nnrelu(x5);

        % layer6 pool2
        x7 = vl_nnpool(x6, [3 3], 'stride', 2, 'pad', [0 1 0 1], 'method', 'avg');

        % layer7 conv3
        % x8 = vl_nnconv(x7,net.layers{7}.weights{1},net.layers{7}.weights{2}, 'stride', 1, 'pad', 2);
        [x8, total(3), ti(3), tz(3)] = nnconv(x7,net.layers{7}.weights{1},net.layers{7}.weights{2}, 1, 2, threshold);

        % layer8 relu3
        x9 = vl_nnrelu(x8);

        % layer9 pool3
        x10 = vl_nnpool(x9, [3 3], 'stride', 2, 'pad', [0 1 0 1], 'method', 'avg');

        % layer10 conv4
        % x11 = vl_nnconv(x10,net.layers{10}.weights{1},net.layers{10}.weights{2}, 'stride', 1, 'pad', 0);
        [x11, total(4), ti(4), tz(4)] = nnconv(x10,net.layers{10}.weights{1},net.layers{10}.weights{2}, 1, 0, threshold);

        % layer11 relu4
        x12 = vl_nnrelu(x11);

        % layer12 conv5
        % x13 = vl_nnconv(x12,net.layers{12}.weights{1},net.layers{12}.weights{2}, 'stride', 1, 'pad', 0);
        [x13, total(5), ti(5), tz(5)] = nnconv(x12,net.layers{12}.weights{1},net.layers{12}.weights{2}, 1, 0, threshold);


        % layer13 softmax
        % y = vl_nnsoftmaxloss(x13, int8(net.layers{13}.class));
        y = vl_nnsoftmax(x13);
        
        index = find(y==max(y));
        if numel(index) > 1
            label = [label, 0];
        else
            label = [label, index];
        end
        label = uint8(label);
        
    end
    
    for cnt = 1:numel(total)
        rate_zero(cnt) = tz(cnt)/total(cnt);
        rate_near_zero(cnt) = ti(cnt)/total(cnt);
    end  
    rate_zero(6) = sum(tz)/sum(total);
    rate_near_zero(6) = sum(ti)/sum(total);
    
    err_rate = sum(numel(nonzeros(label_test-label)))/numel(label);
    disp(['Run at threshold = ',num2str(threshold)]);
    disp(['Run at threshold = 2 ^ ',num2str(th_i-6)]);
    disp(['Zero rate = ',num2str(rate_zero)]);
    disp(['Near zero rate = ',num2str(rate_near_zero)]);
    disp(['error rate = ',num2str(err_rate)]);
    
%     for cnt = 1:numel(total)
%         rate_zero(loop_cnt, cnt) = tz(cnt)/total(cnt);
%         rate_near_zero(loop_cnt, cnt) = ti(cnt)/total(cnt);
%     end  
%     err_rate(loop_cnt) = sum(numel(nonzeros(label_test-label)))/numel(label);
%     loop_cnt = loop_cnt + 1;


    % seek for maximum value and return index :  [x y]=find(A==max(max(A)))
% end


