function z = qlformat(x,qpoint)
    t= int32(round(x*power(2,qpoint))); 
    z= double(t)/(power(2,qpoint)); 
end
