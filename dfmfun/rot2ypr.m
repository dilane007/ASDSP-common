function [yaw pitch roll] = rot2ypr(rot,joints)

rot = rot^(1/joints);
% (pitch, then yaw, then roll)
yaw = atan2(-rot(3,1),sqrt(rot(3,2)^2+rot(3,3)^2));
pitch = atan2(rot(3,2),rot(3,3));
roll = atan2(rot(2,1),rot(1,1));
yaw = -yaw*joints;
pitch = pitch*joints;
roll = -roll*joints;