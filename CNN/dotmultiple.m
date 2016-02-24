function res=dotmultiple(x,y)
global ti total zero;
sx=size(x);

    
for i=1:sx(1)
    for j=1:sx(2)
        if numel(sx)==3
            for k=1:sx(3)
                a=x(i,j,k);
                b=y(i,j,k);
                 if abs(a)<2^-6 && abs(b)<2^-6
                     %if a==0 && b==0
                     %   zero=zero+1;
                     %end
                    tmp=0;
                    ti=ti+1;
                else tmp=a*b;
                 end
                total=total+1;
                res(i,j,k)=tmp;
            end
        else a=x(i,j);
             b=y(i,j);
             if abs(a)<2^-7 && abs(b)<2^-7
                 %if a==0 && b==0
                 %  zero=zero+1;
                 %end
                 tmp=0;
                 ti=ti+1;
             else tmp=a*b;
             end
             total=total+1;
             res(i,j)=tmp;
        end
    
    end
end

end