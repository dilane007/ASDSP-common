function z= mul21s_q(x,y,qpoint)
% enforce data types on output
    zf= x.*y;
    z= qformat(zf,qpoint); 
end