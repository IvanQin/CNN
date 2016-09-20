

% x = imread('peppers.png') ;
% x = x(:,1:384,:)


%----------cifar img1 conv1-------------
load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\aprx\image_test.mat');
% load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\aprx\weight_layer1_filter1.mat')
load('D:\software\Deep_Learning_Tools\MatConvNet\matconvnet-1.0-beta20\data\cifar-lenet\net-epoch-45.mat');
x2 = vl_nnconv(x1, net.layers{1}.weights{1}, net.layers{1}.weights{2}, 'stride', 1, 'pad', 2);
max(reshape(abs(x1),numel(x1),1))
% max(reshape(abs(x2),numel(x2),1))
max(reshape(abs(net.layers{1}.weights{1}),numel(net.layers{1}.weights{1}),1))
max(reshape(abs(net.layers{1}.weights{2}),numel(net.layers{1}.weights{2}),1))
%----------test aprx conv-------------
% x = randn(6,6,3,'single') ;
% w = randn(5,5,3,10,'single') ;
% b = randn(1,10,'single') ;
% y_aprx = nnconv(x, w, b, 1, 0) ;
% y = vl_nnconv(x, w, b);

% %----------test aprx -------------
% 
% accr = single(zeros(1,4));
% aprx = single(zeros(1,4));
% 
% a = 2.175;
% b = 20.123;
% accr(1) = a*b;
% aprx(1) = aprx_mult(a,b);
% 
% a = -9.132;
% b = 10.471;
% accr(2) = a*b;
% aprx(2) = aprx_mult(a,b);
% 
% a = 13.764;
% b = -8.651;
% accr(3) = a*b;
% aprx(3) = aprx_mult(a,b);
% 
% a = -14.624;
% b = -5.551;
% accr(4) = a*b;
% aprx(4) = aprx_mult(a,b);