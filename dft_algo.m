function X= dft_algo( x )
%DFT_ALGO Computes the discrete fourier transform of an input sequence
[m n]=size(x);
if m==1
    N=n;
    X=zeros(1,N);
    for k=1:N
    for m=1:N
        X(1,k)=X(1,k)+x(1,m)*exp(-1i*2*pi*(m-1)*(k-1)/N);
    end
    end
else
    N=m;
    X=zeros(N,1);
    for k=1:N
    for m=1:N
        X(k,1)=X(k,1)+x(m,1)*exp(-1i*2*pi*(m-1)*(k-1)/N);
    end
    end
end

end

