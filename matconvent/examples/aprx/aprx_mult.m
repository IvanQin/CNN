function aprx = aprx_mult(a,b)

sign = 1;
total = 16;
frag = 7;

    a_fi = fi(abs(a),sign,total,frag);  % convert a to 16-bit Q15 signed fixed point
    b_fi = fi(abs(b),sign,total,frag); % convert b to 16-bit Q15 signed fixed point
    
    lzc_a = lzc(a_fi.bin); % calculate the leading zero count of a
    lzc_b = lzc(b_fi.bin); % calculate the leading zero count of b

    lzc_cnt = lzc_a + lzc_b ; % calculate the total leading zero count
    
    %     aprx = fi(2^(-lzc_cnt)+2^(-lzc_cnt-1),sign,total,frag);
    
%     aprx_val = 2^(2*total-lzc_cnt-2*frag-1)+2^(2*total-lzc_cnt-2*frag-2);
    aprx_val = 2^(2*total-lzc_cnt-2*frag-1);
    
if (a > 0 && b > 0) || (a < 0 && b < 0)
    aprx = fi(aprx_val,sign,total,frag);
elseif a == 0 && b == 0
    aprx = fi(0,sign,total,frag);
else
    aprx = fi(-aprx_val,sign,total,frag);
end

end