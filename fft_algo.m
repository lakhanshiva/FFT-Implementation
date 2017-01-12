function X= fft_algo( x, N )
%   Implementation of Fast Fourier Transform
%   Author: Lakhan Kamireddy
%   Course: CSCI 5454, Design and Analysis of algorithms
%   x is the input sequence for which dft is calculated and N is the length of
% fft
if nargin < 2
  N = length(x);
end
l = length(x); %length of input array
log_length=ceil(log2(l)); %These are the stages, there will be log_length stages

if 2^log_length==l && l>1 
    %Below code implements the popular Cooley-Tukey radix-2 FFT
    if(l < N)
        x = [x zeros(1,N-l)]; %zero padding at the end of input
    end
    %X=zeros(1,N);
    %Wn=exp(-1i*2*pi/N); 
    for k=1:N/2 %pre-computation of twiddle factors, stored in a look up array
        Wn(1,k)=exp(-1i*2*pi*(k-1)/N);
    end
    for m=log_length:-1:1
        len=2^(m-1);
        i=1;
        while (i<=(N-1))
            for k=0:1:len-1
                X(i)=x(i)+x(i+len);
                X(i+len)=(x(i)-x(i+len))*(Wn(k+1))^(2^(log_length-m)); %2^(log_length-m) tells how much N is scaled down. log_length-m gives us the stage we are in.
                i=i+1;
                if (k==len-1)
                    i=i+len;
                end
            end
        end
        x=X;
    end
    X=bitrevorder(X); %bit reversal
else%Below code implements non-radix-2 FFT
    %We use Bluestein (Chirp z factor) FFT
    %In this approach we use an existing high-performance FFT and 
    %then apply the convolution theorem to a suitably scaled and conditioned version of the signal.
    m = l;
    w = exp(-1i*2*pi/m); %spiral contour
    a = 1;
    x=x(:);
    % Length for next randix-2 fft.
    next_fft_len = 2^nextpow2(2*m-1);
    kk = ( (-m+1):m-1).';
    kk_pow2 = (kk .^ 2) ./ 2;
    w2 = w .^ (kk_pow2);
    nn = (0:(m-1))';
    a2 = a .^ ( -nn );
    a2 = a2.*w2(m+nn);
    z = x .* a2(:,ones(1,1));
    %Convolution using existing fft.
    xy = fft(  z, next_fft_len );
    xv = fft( 1 ./ w2(1:(2*m-1)), next_fft_len );  %Chirp filter
    xy = xy .* xv(:,ones(1, 1));
    X  = ifft( xy );
    %Final multiplication.
    X = X( m:(2*m-1), : ) .* w2( m:(2*m-1),ones(1, 1) );
    X = X.';
end
end