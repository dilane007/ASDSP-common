function z = qelformat(x,qpoint)
    xr=int64(round(x*power(2,qpoint)));%get rid of under the lsb
    t= xr.*4096.*4096;% another 24<< to saturate
    z= double(t)/power(2,qpoint+24); 
end
