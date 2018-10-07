function [out] = GenText(mi)

fs = 48000;
sensity = 8000;
highAmplitude = 20000;
sample = 5000;


figure; 
subplot(3,1,1);
plot(20000*mi);
title('Tin Hieu Thu');
xlabel('time');



[b a] = butter(5,[3.3/24 3.8/24]);
m = filter(b,a,mi);
m = 20000*abs(m);
subplot(3,1,2); 
plot(m);
title('Tin Hieu Thu Qua Bo Loc Thong Dai');
xlabel('time');



for i = 1:size(m)
    if m(i) > sensity 
        m(i) = highAmplitude;
    else m(i) = 0;
    end
end
subplot(3,1,3); 
plot(m);
title('Tin Hieu Thu Qua Bo So Sanh');
xlabel('time');

flag_1 = 0;
moc = 0;
bitout = 0;
for i = 1: size(m)
    if flag_1 == 0
        if m(i) == highAmplitude
            flag_1 = 1;
            bitout = [1];
            moc = i + 0.8*sample;
        end
    else
        if i > moc && i < moc + 0.4*sample
            if m(i) == highAmplitude
                bitout = [bitout 1];
                moc = i + 0.8*sample;
            end
        elseif i > moc + 0.4*sample
            bitout = [bitout 0];
            moc = i + 0.6*sample;
        end
    end
end
bitout(1) = [];

s = 7 - mod(size(bitout,2),7);
if s < 7
    bitout = [bitout zeros(1,s)];
end
bitout2 = [];
for i = 1:7:size(bitout,2)-6
    if ~(isequaln(bitout(i:i+6), [0 0 0 0 0 0 0]))
        bitout2 = [bitout2 ; bitout(i:i+6)];
    end
end

out = char(bi2de(bitout2,'left-msb'))';
end