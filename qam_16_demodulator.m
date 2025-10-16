function bits = qam_16_demodulator(symbols)
    % 16-QAM demodulator — consistent with normalized 16-QAM mapping
    % Each symbol -> 4 bits

    re = [-3 -1 1 3];
    im = [-3 -1 1 3];
    [Re, Im] = meshgrid(re, im);
    mapping = (Re(:) + 1j * Im(:)) / sqrt(10);  % normalization

    [~, idx] = min(abs(symbols(:) - mapping.'), [], 2); % idx: Nx1
    bit_matrix = de2bi(idx - 1, 4, 'left-msb');         % Nx4
    bits = reshape(bit_matrix.', 1, []);
end
