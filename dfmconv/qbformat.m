function z = qbformat(x,qpoint)
    t =int8(round(x*power(2,qpoint)));
    z= double(t)/(power(2,qpoint)); 
end
