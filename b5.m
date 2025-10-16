run('global_params.m'); % Load global parameters
SNR_db = 0:2:30; % SNR range in dB
time_step_ms = 1; % Time step in milliseconds
sim_time_ms = 500; % Total simulation time in milliseconds
avg_spectral_efficiency = zeros(1, length(SNR_db)); % Initialize average spectral efficiency array
for idx = 1:length(SNR_db)
    results = part_b_overlayer(params, SNR_db(idx), time_step_ms, sim_time_ms);
    avg_spectral_efficiency(idx) = mean(results.spectral_efficiency); % Average spectral efficiency
end

ber_vector = fixed_rate_channel_overlayer(params, SNR_db, time_step_ms, sim_time_ms, 'QPSK');
ber_vector = ber_vector > 1e-2;

figure;
plot(SNR_db, avg_spectral_efficiency, 'm-o', 'LineWidth', 2);
grid on;
xlabel('Average SNR (dB)');
ylabel('Average Spectral Efficiency (bits/s/Hz)');
title('Average Spectral Efficiency vs Average SNR');
axis([min(SNR_db) max(SNR_db) 0 max(avg_spectral_efficiency)+1]);
hold on;

% TODO: Add region markers for BER > 10^-2