function [QuantisedSignal] = Quantiser(L,mp,SampledSignal)
N=length(SampledSignal);
QuantisedSignal=zeros(1,N);
levelwidth = 2*mp/L;
Levels=-mp:levelwidth:mp;
for i=1:length(Levels)-1
    Levels(i)=(Levels(i)+Levels(i+1))/2;
end
Levels(L+1)=[];
for i=1:N
    for j=1:L-1
        if(SampledSignal(i)>Levels(L))
            QuantisedSignal(i)=Levels(L);
            break;
        elseif(SampledSignal(i)<Levels(1))
            QuantisedSignal(i)=Levels(1);
            break;
        elseif(SampledSignal(i)>=Levels(j)&& SampledSignal(i)<=Levels(j+1))
            midpoint=(Levels(j)+Levels(j+1))/2;
            if(SampledSignal(i)>=midpoint&&SampledSignal(i)>=0)
                QuantisedSignal(i)=Levels(j+1);
                break;
            elseif(SampledSignal(i)<midpoint&&SampledSignal(i)>=0)
                 QuantisedSignal(i)=Levels(j);
                 break;
            elseif(SampledSignal(i)<=midpoint&&SampledSignal(i)<0)
                QuantisedSignal(i)=Levels(j);
                break;
            elseif(SampledSignal(i)>midpoint&&SampledSignal(i)<0)
                QuantisedSignal(i)=Levels(j+1);
                break;
            end
            
        end
    end
end
end

