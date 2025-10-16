% Adaptive Modulation Policy
function [modulation_scheme, bits_per_symbol] = adaptive_modulation_policy(snr)
    % Define SNR thresholds for different modulation schemes
    thresholds = [0, 5.48, 10.25, 17.24, 23.47]; % in dB
    modulations = {'No Transmission', 'BPSK', 'QPSK', '16-QAM', '64-QAM'};
    bits_per_symbol_list = [0, 1, 2, 4, 6]; % Corresponding bits per symbol
    
    % Determine the modulation scheme based on SNR
    if snr < thresholds(2)
        modulation_scheme = modulations{1}; % No Transmission
        bits_per_symbol = bits_per_symbol_list(1);
    elseif snr < thresholds(3)
        modulation_scheme = modulations{2}; % BPSK
        bits_per_symbol = bits_per_symbol_list(2);
    elseif snr < thresholds(4)
        modulation_scheme = modulations{3}; % QPSK
        bits_per_symbol = bits_per_symbol_list(3);
    elseif snr < thresholds(5)
        modulation_scheme = modulations{4}; % 16-QAM
        bits_per_symbol = bits_per_symbol_list(4);
    else
        modulation_scheme = modulations{5}; % 64-QAM
        bits_per_symbol = bits_per_symbol_list(5);
    end
end