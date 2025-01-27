%Felliph do Nascimento Silva
%Instrumentação eletrônica ex01

clc
clear

f = 1; %Frequência em Hz
w = 2*pi*f; %Frequência angular
k = 1;
%t = 0:0.01:1;

for t = 0:0.01:1

y(k) = sin(w*t);
t_out(k) = t;
%y = sin(w*t);
k = k+1;

end

out = [t_out ; y];

writematrix(out,'aula01.txt')
plot(t_out,y);
xlabel("tempo(s)");
ylabel("y(t)");

%write =('/home/documentos/Matlab', out)