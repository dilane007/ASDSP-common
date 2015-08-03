% z=MAX161(x,y)   return z, a scalar of the max of 2 rows(x,y) on 8 lanes 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z=max161(x,y);
        u=max(x,y);%round of 16
        v=max(u(1:4),u(5:8));%round of 8
        w=max(v(1:2),v(3:4));%round of 4
        z=max(w(1),w(2));%final
end

