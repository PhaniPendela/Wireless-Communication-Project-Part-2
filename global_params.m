% Global parameters for the wireless communication project
params.CARRIER_FREQUENCY = 2e9; % Carrier frequency in Hz (fc)
params.SYMBOL_RATE = 1e5; % Symbol rate in symbols per second (Rs)
params.MODULATION_SCHEME = 'QPSK'; % Modulation scheme (e.g., 'BPSK', 'QPSK', '16QAM')
params.VELOCITIES = [3, 50, 120]; % User velocities in km/h (v)
params.FADING_DISTRIBUTION = 'Rayleigh'; % Fading distribution type
params.DOPPLER_SPECTRUM = 'Jakes'; % Doppler spectrum type
params.CHANNEL_MODEL = 'Narrowband (Flat Fading)'; % Channel model type

% Additional parameters for Task B
params.MODULATION_SET = ['BPSK', 'QPSK', '16QAM', '64QAM']; % Set of modulation schemes to evaluate
params.TARGET_INSTANTANEOUS_BER = 1e-3; % Target instantaneous BER for adaptive modulation (Pb,target)

% Parameters for simulation
params.NUMBER_OF_BITS = 1e6; % Number of bits to simulate
params.SNR_dB_RANGE = 0:1:25; % SNR range in dB for performance evaluation

% Notes
% SNR_dB_RANGE: 0:2:25 - Faster computation but less resolution
% SNR_dB_RANGE: 0:1:25 - Slower computation but higher resolution
% SNR_dB_RANGE: 0:5:50 - For knowing the curve trend quickly