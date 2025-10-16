function bits = demodulator(equalized_signal, modulation_scheme)
    % Demodulate received symbols based on the modulation scheme
    switch modulation_scheme
        case "BPSK"
            bits = bpsk_demodulator(equalized_signal); % BPSK Demodulation
        case "QPSK"
            bits = qpsk_demodulator(equalized_signal); % QPSK Demodulation
        case "16-QAM"
            bits = qam_16_demodulator(equalized_signal); % 16-QAM Demod
        case "64-QAM"
            bits = qam_64_demodulator(equalized_signal); % 64-QAM Demod
        otherwise
            bits = []; % No transmission
    end
end