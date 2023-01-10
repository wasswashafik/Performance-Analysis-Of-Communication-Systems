%Quadrature Phase Shift Keying
clc
clear
M = 4; % Alphabet size
EbN0_min=2;EbN0_max=9;step=1;
SNR_QPSK=[];BER_QPSK=[];
for EbN0 = EbN0_min:step:EbN0_max
SNR_dB_QPSK=EbN0 + 3; %for QPSK Eb/N0=0.5*Es/N0=0.5*SNR
x = randi(M,1000000,1)-1;
y=qammod(x,M);
ynoisy = awgn(y,SNR_dB_QPSK,'measured');
z=qamdemod(ynoisy,M);
[num,rt]= biterr(x,z);
SNR_QPSK=[SNR_QPSK EbN0];
BER_QPSK=[BER_QPSK rt];
end

SNR_dB_QPSK=[2:1:9];
theoryBer_QPSK = 0.5*erfc(sqrt(10.^(SNR_dB_QPSK/10))); % theoretical ber
close all
figure
semilogy(SNR_dB_QPSK,theoryBer_QPSK,'b.-');
hold on
semilogy(SNR_QPSK,BER_QPSK,'mx-');
grid on
legend('theory', 'simulation');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for QPSK modulation');