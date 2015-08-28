%zm=cxmag(z) returns magnitude of complex number(z)
function zm=cxmag(z)
     zr= real(z);
     zi= imag(z);
     zm=sqrt(zr.^2+zi.^2);
end