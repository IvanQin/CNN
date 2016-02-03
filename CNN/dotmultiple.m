function res=dotmultiple(x,y)
global ti total;
sx=size(x);
for i=1:sx(1)
    for j=1:sx(2)
        for k=1:sx(3)
            tmp=x(i,j,k)*y(i,j,k);
            if abs(tmp)<2^-15
                tmp=0;
                ti=ti+1;
            end
            total=total+1;
            res(i,j,k)=tmp;
        end
    end
end

end