syms t;
f(t) = 5*sin(2*pi*t);
[t,S] = IdealSampler(f,50);
Q = Quantiser(16,5,S);
y= upsample(Q,4);
SNR=0:0.01:40;
for m=1:length(SNR)
noisyy=awgn(y,SNR(m));
%%y=conv(y,[1,1,1,1]);
noisyy=conv(noisyy,[1 1 1 1]);
for i=1:length(y)/4
    x(i)=y(4*i);
end
for i=1:length(y)/4
    noisyx(i)=noisyy(4*i);
end
output=Quantiser(16,5,noisyx);
Ber=0;
Diff=Q-output;
for i=1:length(Diff)
    if(Diff(i)~=0)
        Ber=Ber+1;
    end
end
 BitErrorRate(m)= Ber/length(Diff);
end
semilogx(SNR,BitErrorRate);