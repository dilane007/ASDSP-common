function z = qshift(x,y)
y= double(int8(y));%shift value is limited
z= times(x,power(2,y));   
