function boxplot(x)
%Example
% x = [rand(100,4); (4*rand(10,4)-2)];
% Boxplot start
    sx = sort(x)
    n = size(x,1)
    nm4 = mod(n,4)
    if nm4 == 1
        q1 = 0.25.*sx(floor(n/4),:)+0.75.*sx(floor(n/4+1),:);
        q3 = 0.75.*sx(floor(3*n/4+1),:)+0.75.*sx(floor(3*n/4+2),:);
        q2 = (sx(floor(n/2),:) + sx(ceil(n/2),:))./2;
    else
        if nm4 == 3
            q1 = 0.75.*sx(floor(n/4+1),:)+0.25.*sx(floor(n/4+2),:);
            q3 = 0.25.*sx(floor(3*n/4+2),:)+0.75.*sx(floor(3*n/4+3),:);
            q2 = (sx(floor(n/2),:) + sx(ceil(n/2),:))./2;
        else
            q2 = sx(n/2,:);
            q1 = (sx(floor(n/4),:)+sx(ceil(n/4),:))./2;
            q3 = (sx(floor(3*n/4),:)+sx(ceil(3*n/4),:))./2;
        end
    end
    iqr = q3 - q1;
    f1 = max(sx(1,:), q1 - 1.5*iqr);
    f3 = min(sx(n,:), q3 + 1.5*iqr);
    for c = 1:size(x,2)
        boxptsx = c-1+[0.6 0.6 1.4 1.4 0.6];
        boxptsy = [q3(c) q1(c) q1(c) q3(c) q3(c)];
        plot(boxptsx, boxptsy, 'b');
        medptsx = c-1+[0.6 1.4];
        medptsy = [q2(c) q2(c)];
        hold on;
        plot(medptsx, medptsy, 'r');
        wiskptsx = c-1+[0.8 1.2];
        wiskptsy = [f1(c) f1(c)];
        hold on;
        plot(wiskptsx, wiskptsy, 'k');
        wiskptsx = c-1+[0.8 1.2];
        wiskptsy = [f3(c) f3(c)];
        hold on;
        plot(wiskptsx, wiskptsy, 'k');
        wiskptsx = [c c];
        wiskptsy = [q3(c) f3(c)];
        hold on;
        plot(wiskptsx, wiskptsy, 'k:');
        wiskptsx = [c c];
        wiskptsy = [q1(c) f1(c)];
        hold on;
        plot(wiskptsx, wiskptsy, 'k:');
        a = sx(:,c);
        outliersy = [a(find(a < f1(c))); a(find(a > f3(c)))];
        outliersx = c+zeros(size(outliersy));
        hold on;
        plot(outliersx, outliersy, 'rx');
    end
    xlim([0 (size(x,2)+1)])
    ylim([(min(min(x))-max(iqr)) (max(max(x))+max(iqr))])
end