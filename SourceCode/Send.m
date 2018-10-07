function Send(in)

highAmplitude = 20000;
sample = 5000;
fs = 48000;
ftranfer = 3500;
t = 0:2*pi/(fs/ftranfer):10000*pi;
one = sin(t);

clc
ze = zeros(1,sample);
on = [highAmplitude*one(1:100) zeros(1,sample-100)];
ce = [ze on];
bit = in;
for i = 1:size(bit,2)
    if bit(i) == 1
        ce = [ce on];
    else
        ce = [ce ze];
    end
end
figure;
plot(ce);
title('Tin Hieu Phat');
xlabel('time');
size(ce);
sound(ce,fs,8);
end