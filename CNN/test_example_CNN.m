global ti total zero;
ti=0;
total=0;
zero=0;
%function test_example_CNN
load mnist_uint8;
%load ('../cifar-10-batches-mat/CIFAR10_uint8.mat');
addpath('./util/');
train_x = double(reshape(train_x',28,28,60000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y');
test_y = double(test_y');

%train_x = double(reshape(train_x',32,32,50000))/255;
%test_x = double(reshape(test_x',32,32,10000))/255;
%train_y = double(train_y');
%test_y = double(test_y');


%% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
%will run 1 epoch in about 200 second and get around 11% error. 
%With 100 epochs you'll get around 1.2% error

rand('state',0)

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer 6 5
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer 6 5
    struct('type', 's', 'scale', 2) %sub sampling layer
};


opts.alpha = 1;
opts.batchsize = 50;
opts.numepochs = 1;

cnn = cnnsetup(cnn, train_x, train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);

[er, bad] = cnntest(cnn, test_x, test_y);

%plot mean squared error
figure; plot(cnn.rL);grid on;
assert(er<0.12, 'Too big error');
disp(er);
disp(['ti= ' num2str(ti)]);
disp(['total= ' num2str(total)]);
disp(['zero= ' num2str(zero)]);
clear global;