%Script to test execution times for fft vs dft implementation
x=[]
%for i=1:2^10;
%    x=[x i];
%end
%x=[1 2 3];
x=0:10;
x1=[1];
x2=[1 2];
x3=[1 2 3 4];
x4=[1 2 3 4 5 6 7 8];
x5=[];
for i=1:2^4+1
    x5=[x5 i];
end
x6=[];
for i=1:2^5+1
    x6=[x6 i];
end
x7=[];
for i=1:2^6+1
    x7=[x7 i];
end
x8=[];
for i=1:2^7+1
    x8=[x8 i];
end
x9=[];
for i=1:2^8+1
    x9=[x9 i];
end
x10=[];
for i=1:2^9+1
    x10=[x10 i];
end
x11=[];
for i=1:2^10+1
    x11=[x11 i];
end

for i=1:11
tic
p=strcat('x',num2str(i));
varname = genvarname(p);
eval(['k=',varname,';']);
fft_algo(k);
elapsed_time_own_fft(i)=toc;
end
plot(x,elapsed_time_own_fft);

for i=1:11
tic
p=strcat('x',num2str(i));
varname = genvarname(p);
eval(['k=',varname,';']);
c=dft_algo(k);
elapsed_time_dft(i)=toc;
end
hold;
plot(x,elapsed_time_dft);

legend('show');