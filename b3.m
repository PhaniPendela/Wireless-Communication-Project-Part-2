run('global_params.m'); % Load global parameters
SNR_db = 20; % Average SNR in dB
time_step_ms = 1; % Time step in milliseconds
sim_time_ms = 500; % Total simulation time in milliseconds

results = part_b_overlayer(params, SNR_db, time_step_ms, sim_time_ms);

% Plotting the results
figure;
subplot(2, 1, 1);
plot(results.time_vector, results.instantaneous_snr, 'b', 'LineWidth', 1.5);
title('Instantaneous SNR vs Time');
xlabel('Time (ms)');
ylabel('Instantaneous SNR (dB)');
grid on;
subplot(2, 1, 2);
plot(results.time_vector, results.spectral_efficiency, 'r', 'LineWidth', 1.5);
title('Spectral Efficiency vs Time');
xlabel('Time (ms)');
ylabel('Spectral Efficiency (bits/s/Hz)');
grid on;