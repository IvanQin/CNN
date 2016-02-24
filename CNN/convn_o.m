function res=convn_o(x,y,opti)
global ti total zero;
addpath('./util/');
y=flipall(y);

sx=size(x);

sy=size(y);
if numel(sx)==3 && numel(sy)==3 % 3-D & 3-D convolution
    bi=1-sy+sx;
    for k=1:bi(3)
        for i=1:bi(1)
            for j=1:bi(2)
                s=0;
                p=sqrt(sy(1)*sy(2)*sy(3));
                threshold=(2^-6/p);
                for ii=1:sy(1)
                    for jj=1:sy(2)
                        for kk=1:sy(3)
                            a=x(i+ii-1,j+jj-1,k+kk-1);
                            b=y(ii,jj,kk);
                            if abs(a)<threshold && abs(b)<threshold
                                %if a==0 && b==0
                                %  zero=zero+1;
                                %end
                                ti=ti+1;
                                tmp=0;
                            else tmp=a*b;
                                
                            end
                            total=total+1;
                            s=s+tmp;
                        end
                    end
                end
                res(i,j,k)=s;
            end
        end
    end
                            
else
%3-D & 2-D convolution
if strcmp(opti,'valid') 
    bi=1-sy+sx(1:2);
else bi=sx(1:2)+sy-1;
end
bi=[bi sx(3)];

for k=1:bi(3)
    for i=1:bi(1)
        for j=1:bi(2)
            p=sqrt(sy(1)*sy(2));
            s=0;
            threshold=(2^-6/p);
            for ii=1:sy(1)
                for jj=1:sy(2)
                        
                        if strcmp(opti,'valid') 
                            a=x(i+ii-1,j+jj-1,k);
                            b=y(ii,jj);
                            tmp=a*b;
                            
                        elseif i-sy(1)+ii>0 && j-sy(2)+jj>0 && i-sy(1)+ii<=sx(1) && j-sy(2)+jj<=sx(2) 
                            a=x(i-sy(1)+ii,j-sy(2)+jj,k);
                            b=y(ii,jj);
                            tmp=a*b;
                        else a=0;
                             b=0;
                            
                        end
                        
                        if abs(a)<threshold && abs(b)<threshold
                            %if a==0 && b==0
                            %    zero=zero+1;
                            %end
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

end
end

