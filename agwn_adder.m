% Additive White Gaussian Noise (AWGN) adder function
function noisy_signal = agwn_adder(signal, SNR_dB)
    % Input:
    %   signal - Original signal to which noise is to be added
    %   SNR_dB - Desired Signal-to-Noise Ratio in decibels
    % Output:
    %   noisy_signal - Signal after adding AWGN

    % Calculate signal power
    signal_power = mean(abs(signal).^2);
    
    % Convert SNR from dB to linear scale
    SNR_linear = 10^(SNR_dB / 10);
    
    % Calculate noise power
    noise_power = signal_power / SNR_linear;
    
    % Generate white Gaussian noise
    noise = sqrt(noise_power) * randn(size(signal));
    
    % Add noise to the original signal
    noisy_signal = signal + noise;
end