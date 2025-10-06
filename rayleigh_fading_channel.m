% Rayleigh Fading Channel function
% Configure the Rayleigh fading channel using comm.RayleighChannel
function rayleighChannel = rayleigh_fading_channel(params)
    % Input:
    %   params - Structure containing global parameters
    % Output:
    %   rayleighChannel - Configured Rayleigh fading channel object

    % Convert velocities from km/h to m/s
    velocities_mps = params.VELOCITIES * (5 / 18);
    
    % Calculate maximum Doppler shifts for each velocity
    maxDopplerShifts = (velocities_mps / 3e8) * params.CARRIER_FREQUENCY;

    for k = 1:length(velocities_mps)
        % Create Rayleigh channel object
        rayleighChannel{k} = comm.RayleighChannel(...
            'SampleRate', params.SYMBOL_RATE, ...
            'MaximumDopplerShift', maxDopplerShifts(k), ...
            'DopplerSpectrum', doppler(params.DOPPLER_SPECTRUM), ...
            'PathGainsOutputPort', true);
    end
end