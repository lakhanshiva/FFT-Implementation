x= randi(10);
N=2^x;
%N=2^x+1 %Non power-of-2 sequence inputs
seq =[];
for i=1:N
    seq=[seq randi(100)];
end
current_fft = fft_algo(seq);
f1 = abs(current_fft);
subplot(2,2,1)
plot(f1)
title('Current FFT implementation (Magnitude)');
matlab_fft = fft(seq);
f2 = abs(matlab_fft);
subplot(2,2,2)
plot(f2)
title('Matlab FFT implementation (Magnitude)');
f3 = angle(current_fft);
subplot(2,2,3)
plot(f3)
title('Current FFT implementation (Angle)');
f4 = angle(matlab_fft);
subplot(2,2,4)
plot(f4)
title('Matlab FFT implementation (Angle)');