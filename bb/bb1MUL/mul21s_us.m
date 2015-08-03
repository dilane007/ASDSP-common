function z= mul21s_us(x,y)
% alias
% enforce data types
    x= uint16(x);
    y= uint16(y);
    z= times(x,y);
end