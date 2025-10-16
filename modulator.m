function symbols = modulator(bit_stream, modulation_scheme)
    % Modulates the input bit stream based on the specified modulation scheme
    if modulation_scheme == "BPSK"
        symbols = bpsk_modulator(bit_stream);
    elseif modulation_scheme == "QPSK"
        symbols = qpsk_modulator(bit_stream);
    elseif modulation_scheme == "16-QAM"
        symbols = qam_16_modulator(bit_stream);
    elseif modulation_scheme == "64-QAM"
        symbols = qam_64_modulator(bit_stream);
    else
        error('Unsupported modulation scheme');
    end
end