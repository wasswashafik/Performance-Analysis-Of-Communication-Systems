clear, clc
% set up On-Off Keying(OOK)
nSymb = 2; % number of points in constellation
N = 10^5; % number of symbols transmitted
nSNR = 30; % number of signal to noise ratio values to use
errorRate = comm.ErrorRate; %enable error rate stats

% define SNR
SNRmin = 2; %min SNR (dB) value
SNRmax = 9; %max SNR (dB) value
SNRdB_OOK = linspace(SNRmin,SNRmax,nSNR); % SNR in dB matrix

% signal and noise power
sigAmp = 1;
sigP = sigAmp^2; % signal power
noiseP = 1./SNRdB_OOK; % noise power = variance of white noise
    
for n = 1:nSNR % for each SNR value ... compute a BER
    data = randi([0 nSymb-1],N,1);  %define the PRBS
    const = [0 1];  %configure OOK, BPSK, QPSK
    modSignal = genqammod(data,const);

    % Introduce noise on top of channel
    added_noise = sqrt(noiseP(n)/2)*randn(N,1); % noise only in one dimension
    noisy_signal = modSignal+added_noise;
%     snrAct(n) = 1/(1*var(added_noise)); % convert SNR measurement from dB to linear

    %demod with ook
    demodData_matlab = genqamdemod(noisy_signal,const);
    
    % Compute BER.
    reset(errorRate);  %reset error stats each iteration through loop
    errorStats = errorRate(data,demodData_matlab);  %error stats such as BER
    ber_OOK(n) = errorStats(1);  %BER
    
end

theory_OOK =qfunc(sqrt(0.5./noiseP));

figure
semilogy(SNRdB_OOK,theory_OOK,'b.-');
hold on;
grid
semilogy(SNRdB_OOK,ber_OOK,'mx-');
legend('theory', 'simulation');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for OOK modulation');