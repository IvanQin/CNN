function res=matrixmul(A,B)
global ti total;
d1=size(A,1);
d2=size(A,2);
d3=size(B,2);
for i=1:d1
    for j=1:d3
        s=0;
        for k=1:d2
            a=A(i,k);
            b=B(k,j);
            if abs(a)<2^-7 && abs(b)<2^-7
                ti=ti+1;
            else  s=s+a*b;
            end
           
            total=total+1;
        end
        res(i,j)=s;
    end
end
end


