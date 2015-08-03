function result = getTime(time)

tempTime = mod(time,1)*24;
hour = floor(tempTime);
tempTime = mod(tempTime,1)*60;
min = floor(tempTime);
tempTime = mod(tempTime,1)*60;
sec = floor(tempTime);

result = sprintf('%dh%dmn%dsec', hour, min, sec);