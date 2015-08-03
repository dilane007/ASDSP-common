function z = qeformat(x,qpoint)
    t=int64(round(x*power(2,qpoint)));
    z= double(t)/power(2,qpoint); 
end
