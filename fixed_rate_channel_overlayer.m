function results = fixed_rate_channel_overlayer(params, snr_range, time_step_ms, sim_time_ms, modulation_scheme)
    rayleigh_channels = rayleigh_fading_channel(params); % Create Rayleigh fading channels

    time_vector = 0:time_step_ms:sim_time_ms; % Time vector from 0 to sim_time_ms milliseconds
    N = params.SYMBOL_RATE * (time_vector(end) / 1000); % Number of symbols for the entire duration
    bit_stream = random_bit_generator(N * 2); % Generate random bits

    modulated_symbols = modulator(bit_stream, modulation_scheme); % Modulate bits
    modulated_symbols = modulated_symbols.'; % Transpose to column vector

    [faded_signal, path_gains] = rayleigh_channels{2}(modulated_symbols); % Apply Rayleigh fading
    ber_vector = zeros(1, length(snr_range));
    for idx = 1:length(snr_range)
        snr = snr_range(idx);
        received_signal = agwn_adder(faded_signal, snr); % Add AWGN noise
        equalized_signal = received_signal ./ path_gains; % Equalization
        received_bits = qpsk_demodulator(equalized_signal); % QPSK Demodulation

        % BER calculation
        [numErrors, errorRate] = error_rate_calculator(bit_stream, received_bits);
        ber_vector(idx) = errorRate;
    end
    results.snr_range = snr_range;
    results.ber_vector = ber_vector;
end