%%%% BPSK transmission over AWGN channel
%BPSK BER (Binary Phase Shift Keying, Bit Error rate)
clc
clear

const=[1 -1];
size=100000;
iter_max=1000;
SNR_min=2;
SNR_max=9;
nSNR = 10; % number of signal to noise ratio values to use

SNR_BPSK=[];BER_BPSK=[];
for EbN0 = SNR_min:0.5:SNR_max % looping through SNRs
EbN0_lin=10.^(0.1*EbN0);
noise_var=0.5/(EbN0_lin); % s^2=N0/2
iter = 0;
err = 0;
while (iter <iter_max && err <100)
bits=randsrc(1,size,[0 1]);
s=const(bits+1);
x = s + sqrt(noise_var)*randn(1,size);
bit_hat=(-sign(x)+1)/2;
err = err + sum(bits ~= bit_hat);
iter = iter + 1;
end
SNR_BPSK =[SNR_BPSK EbN0];
BER_BPSK = [BER_BPSK err/(size*iter)];
end
SNR_dB_BPSK=[2:(1/nSNR):9];
theoryBer_BPSK = 0.5*erfc(sqrt(10.^(SNR_dB_BPSK/10))); % theoretical ber

% plot
close all
figure
semilogy(SNR_dB_BPSK,theoryBer_BPSK,'b.-');
hold on
semilogy(SNR_BPSK,BER_BPSK,'mx-');
grid on
legend('theory', 'simulation');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation');

