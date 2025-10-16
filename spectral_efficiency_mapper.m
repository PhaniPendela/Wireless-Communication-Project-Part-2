% Spectral Efficiency Mapper
function se = spectral_efficiency_mapper(modulation_scheme)
    switch modulation_scheme
        case 'BPSK'
            se = 1; % bits/s/Hz
        case 'QPSK'
            se = 2; % bits/s/Hz
        case '16QAM'
            se = 4; % bits/s/Hz
        case '64QAM'
            se = 6; % bits/s/Hz
        otherwise
            se = 0; % No transmission
    end
end