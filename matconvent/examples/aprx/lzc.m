function y = lzc(x)
y=0;
t = num2str(x);
for i=1:length(t)
    if t(i) == '0'
        y = y + 1;
    else
        break;
    end
end
end