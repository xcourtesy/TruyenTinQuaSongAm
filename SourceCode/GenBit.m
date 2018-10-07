function [out] = GenBit(in)
a = dec2bin(in);
out = [];
for i = 1:size(a,1);
    out = [out a(i,:) ];
end
for i = 1:size(out,2)
    out(i) = out(i) - 48;
end
end