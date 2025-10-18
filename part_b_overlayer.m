function results = part_b_overlayer(params, snr_average, time_step_ms, sim_time_ms)
    rayleigh_channels = rayleigh_fading_channel(params); % Create Rayleigh fading channels

    time_vector = 0:time_step_ms:sim_time_ms; % Time vector from 0 to sim_time_ms milliseconds
    N = params.SYMBOL_RATE * (time_vector(end) / 1000); % Number of symbols for the entire duration
    
    instantaneous_snr = zeros(1, length(time_vector)); % Initialize instantaneous SNR array
    channel_gain = zeros(1, length(time_vector)); % Initialize channel gain array
    spectral_efficiency = zeros(1, length(time_vector)); % Initialize spectral efficiency array
    modulation_schemes = strings(1, length(time_vector)); % Initialize modulation scheme array

    dummy_input = complex(ones(1, 1), 0); % Dummy input for channel gain calculation
    for idx = 1:length(time_vector)
        [~, path_gains] = rayleigh_channels{2}(dummy_input); % Apply Rayleigh fading to a vector of ones
        channel_gain(idx) = 20 * log10(abs(path_gains)); % Get channel gains in dB
        instantaneous_snr(idx) = snr_average + channel_gain(idx); % Instantaneous SNR in dB
        [modulation_scheme, bits_per_symbol] = adaptive_modulation_policy(instantaneous_snr(idx));
        spectral_efficiency(idx) = spectral_efficiency_mapper(modulation_scheme); % Spectral efficiency in bits/s/Hz
        modulation_schemes(idx) = modulation_scheme; % Store modulation scheme

        if bits_per_symbol == 0
            continue; % Skip if no transmission
        end

        % Transmit and receive simulation
        bit_stream = random_bit_generator(bits_per_symbol * N); % Generate random bits
        modulated_symbols = modulator(bit_stream, modulation_scheme); % Modulate bits
        modulated_symbols = modulated_symbols.'; % Transpose to column vector

        % Apply Rayleigh fading and add AWGN noise
        [faded_signal, path_gains] = rayleigh_channels{2}(modulated_symbols);
        received_signal = agwn_adder(faded_signal, instantaneous_snr(idx)); % Add AWGN noise
        equalized_signal = received_signal ./ path_gains; % Equalization

        % Demodulate received symbols
        received_bits = demodulator(equalized_signal, modulation_scheme);
    end

    % store results
    results.time_vector = time_vector;
    results.instantaneous_snr = instantaneous_snr;
    results.channel_gain = channel_gain;
    results.spectral_efficiency = spectral_efficiency;
    results.modulation_schemes = modulation_schemes;
end

