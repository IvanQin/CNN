function [y, total, sum_ti, sum_tz]  = nnconv( x, f , b, stride, pad, threshold)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% x = h * w * c * n;
% f = fh * fw * fc * k;
% y = yh * yw * k * n;
% yh = ((h - (fh-1)) + 2*pad) / stride
% yw = ((w - (fw-1)) + 2*pad) / stride

% global total;

[h, w, c, nx] = size(x);
[fh, fw, fc, fk] = size(f);


i_range = (h - (fh-stride)) + 2*pad;
j_range = (w - (fw-stride)) + 2*pad;

yh = i_range / stride;
yw = j_range / stride;


xpad = padarray(x, [pad pad]);

y = zeros(yh, yw, fk, nx);

i_cnt = i_range/stride;
j_cnt = j_range/stride;

sum_ti=0;
sum_tz=0;
total= fh*fw*fc*i_cnt*j_cnt*fk*nx;

if isempty(b)
    for n = 1: nx
        for k = 1: fk
            for j = 1: stride : j_range+1 
                for i = 1: stride : i_range+1 
                    [y(i,j,k,n), ti, tz] = mat_apr_mac( xpad(i:i+fh-1,j:j+fw-1,:,n), f(:,:,:,k), threshold);
                    sum_ti= sum_ti + ti;
                    sum_tz= sum_tz + tz;
                end
            end
        end
    end
else
    for n = 1: nx
        for k = 1: fk
            for j = 1: stride : j_range 
                for i = 1: stride : i_range 
                    [y(i,j,k,n), ti, tz] = mat_apr_mac( xpad(i:i+fh-1,j:j+fw-1,:,n), f(:,:,:,k), threshold);
                    y(i,j,k,n) = y(i,j,k,n) + b(fk);
                    sum_ti= sum_ti + ti;
                    sum_tz= sum_tz + tz;
                end
            end
        end
    end  
end
end

