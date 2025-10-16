run('global_params.m'); % Load global parameters
SNR_db = 20; % Average SNR in dB
time_step_ms = 1; % Time step in milliseconds
sim_time_ms = 500; % Total simulation time in milliseconds

results = part_b_overlayer(params, SNR_db, time_step_ms, sim_time_ms);

percentage_time = zeros(1, 5); % Initialize percentage time array for 5 modes

mod_schemes = ["No Transmission", "BPSK", "QPSK", "16-QAM", "64-QAM"];

for i = 1:length(mod_schemes)
    percentage_time(i) = sum(results.modulation_schemes == mod_schemes(i)) / length(results.modulation_schemes) * 100;
end

% Plotting the results
figure;
bar(categorical(mod_schemes), percentage_time, 'FaceColor', [0.2 0.5 0.8]);
xlabel('Transmission Mode', 'FontSize', 12);
ylabel('Percentage of Time (%)', 'FontSize', 12);
title('Mode Selection Histogram (Adaptive Modulation)', 'FontSize', 14, 'FontWeight', 'bold');
grid on;