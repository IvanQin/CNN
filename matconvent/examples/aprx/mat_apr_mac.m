function [sum, ti, tz]  = mat_apr_mac( a, b, threshold)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% global ti tz threshold;
ti=0;
tz=0;
sum = 0;
for c = 1 : size(a,3)
    for j = 1 : size(a,2)
        for i = 1: size(a,1)
            % sum = sum + aprx_mult(a(i,j,c), b(i,j,c));
%             sum = sum + a(i,j,c)*b(i,j,c);
            if a(i,j,c) == 0 || b(i,j,c) == 0
                tz=tz+1;
                ti=ti+1;
                continue;
            else
                p_sum = a(i,j,c)*b(i,j,c);
            end
            
            if abs(p_sum) <= threshold
                ti=ti+1;
            else
                sum = sum + p_sum;
            end
        end
    end
end

end

