clear all;
[filename, pathname]=uigetfile('*.idx1-ubyte','pick up labels');
FID=fopen(filename,'r');
fread(FID,32,'ubit1');
magicnumber=data(fread(FID,32,'ubit1'));
numberOfLabels=data(fread(FID,32,'ubit1'));
for i=1:numberOfLabels
    label(i)=data(fread(FID,8,'ubit1'));
end

