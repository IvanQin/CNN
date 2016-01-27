function data=b2i(b)
s=size(b);
data=0;
for i=1:s
    data=data*2+b(i);
end
end