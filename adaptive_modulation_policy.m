% Adaptive Modulation Policy
function modulation_scheme = adaptive_modulation_policy(snr)
    % Define SNR thresholds for different modulation schemes
    thresholds = [0, 5.48, 10.25, 17.24, 23.47]; % in dB
    modulations = {'No Transmission', 'BPSK', 'QPSK', '16-QAM', '64-QAM'};
    
    % Determine the modulation scheme based on SNR
    if snr < thresholds(2)
        modulation_scheme = modulations{1}; % No Transmission
    elseif snr < thresholds(3)
        modulation_scheme = modulations{2}; % BPSK
    elseif snr < thresholds(4)
        modulation_scheme = modulations{3}; % QPSK
    elseif snr < thresholds(5)
        modulation_scheme = modulations{4}; % 16-QAM
    else
        modulation_scheme = modulations{5}; % 64-QAM
    end
end