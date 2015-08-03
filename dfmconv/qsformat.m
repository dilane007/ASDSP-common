function z = qsformat(x,qpoint)
    t =int16(round(x*power(2,qpoint)));
    z= double(t)/(power(2,qpoint)); 
end
