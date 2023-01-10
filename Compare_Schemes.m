load('QPSK');
load('OOK');
load('BPSK');
figure
semilogy(SNR_dB_QPSK,theoryBer_QPSK,'r-');
hold on
semilogy(SNR_QPSK,BER_QPSK,'*-');
hold on
semilogy(SNRdB_OOK,theory_OOK,'b.-');
hold on;
grid on
semilogy(SNRdB_OOK,ber_OOK,'g-');
hold on
semilogy(SNR_dB_BPSK,theoryBer_BPSK,'b.-');
hold on
semilogy(SNR_BPSK,BER_BPSK,'mx-');
grid on
legend('theory_{QPSK}', 'simulation_{QPSK}','theory_{OOK}','simulation_{OOK}','theory_{BPSK}','simulation_{BPSK}');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK,OOK, and QPSK modulation');