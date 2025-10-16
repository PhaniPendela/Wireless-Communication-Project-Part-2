run('global_params.m'); % Load global parameters
rayleigh_channels = rayleigh_fading_channel(params); % Create Rayleigh fading channels

bit_stream = random_bit_generator(params.NUMBER_OF_BITS); % Generate random bits
modulated_symbols = qpsk_modulator(bit_stream); % QPSK Modulation
modulated_symbols = modulated_symbols.'; % Transpose to column vector

% Further processing can be done here, such as passing through the channel,
ber_matrix = zeros(length(params.VELOCITIES), length(params.SNR_dB_RANGE)); % Initialize BER matrix
ber_theoretical = berawgn(params.SNR_dB_RANGE, 'psk', 4, 'nondiff'); % Theoretical BER for QPSK
for k = 1:length(rayleigh_channels)
    [faded_signal, path_gains] = rayleigh_channels{k}(modulated_symbols); % Apply Rayleigh fading
    N = params.SYMBOL_RATE * 0.5; % Number of samples for 0.5 seconds
    channel_gain = 20 * log10(abs(path_gains)); % Get channel gains in dB
    time = (0:N-1) / params.SYMBOL_RATE; % Time vector for 0.5 seconds
    time_ms = time * 1000; % Convert to milliseconds

    figure;
    plot(time_ms, channel_gain(1:N));
    title(['Channel Gain vs Time for Velocity ' num2str(params.VELOCITIES(k)) ' km/h']);
    xlabel('Time (ms)');
    ylabel('Channel Gain (dB)');
    grid on;

    % Add AWGN noise and perform QPSK demodulation
    ber_vector = zeros(1, length(params.SNR_dB_RANGE));
    for idx = 1:length(params.SNR_dB_RANGE)
        snr = params.SNR_dB_RANGE(idx);
        received_signal = agwn_adder(faded_signal, snr); % Add AWGN noise
        equalized_signal = received_signal ./ path_gains; % Equalization
        received_bits = qpsk_demodulator(equalized_signal); % QPSK Demodulation

        % BER calculation
        [numErrors, errorRate] = error_rate_calculator(bit_stream, received_bits);
        ber_vector(idx) = errorRate;
    end

    ber_matrix(k, :) = ber_vector; % Store BER results
end

% Plot BER vs SNR results
figure;
semilogy(params.SNR_dB_RANGE, ber_theoretical, 'k--', 'LineWidth', 2); % Theoretical BER
hold on;
colors = ['r', 'g', 'b'];
for k = 1:length(params.VELOCITIES)
    semilogy(params.SNR_dB_RANGE, ber_matrix(k, :), [colors(k) '-o'], 'LineWidth', 2);
end
hold off;
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for QPSK over Rayleigh Fading Channel');
legend('Theoretical', '3 km/h', '50 km/h', '120 km/h');
axis([min(params.SNR_dB_RANGE) max(params.SNR_dB_RANGE) 1e-5 1]);