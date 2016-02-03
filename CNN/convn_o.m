function res=convn_o(x,y,opti)
global ti total;
addpath('./util/');
y=flipall(y);

sx=size(x);

sy=size(y);

if strcmp(opti,'valid') 
    bi=1-sy+sx(1:2);
else bi=sx(1:2)+sy-1;
end
bi=[bi sx(3)];

for k=1:bi(3)
    for i=1:bi(1)
        for j=1:bi(2)
        
            s=0;
            for ii=1:sy(1)
                for jj=1:sy(2)
                   
                        if strcmp(opti,'valid') 
                            tmp=x(i+ii-1,j+jj-1,k)*y(ii,jj);
                        elseif i-sy(1)+ii>0 && j-sy(2)+jj>0 && i-sy(1)+ii<=sx(1) && j-sy(2)+jj<=sx(2) 
                            tmp=x(i-sy(1)+ii,j-sy(2)+jj,k)*y(ii,jj);
                        else tmp=0;
                        end
                        if abs(tmp)<2^-15
                            ti=ti+1;
                            tmp=0;
                        end
                        total=total+1;
                        s=s+tmp;
                   
                end
            end
            res(i,j,k)=s;   
        end
    end
end
