% figure uplink
gain = sta.gmb;
sir = sta.sirdmb;
figure(1)
sind = sum(isfinite(sir),2)==1;
mind = sum(isfinite(sir),2)>1;
ind = index((1:size(sir,1))',sortind(-sir,2),size(sir));
g = gain(ind);
s = sir(ind);
plotnh(g(sind,:)',s(sind,:)','.')
set(get(gca,'children'),'linewidth',2)
pause
ploth(g(mind,:)',s(mind,:)','.-')

title('Lines concatenate Links in a Connection')
xlabel('Path Gain [dB]')
ylabel('SIR Down Link [dB]')
