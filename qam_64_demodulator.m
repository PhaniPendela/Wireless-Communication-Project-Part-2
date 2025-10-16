function bits = qam_64_demodulator(symbols)
    % 64-QAM demodulator — consistent with normalized 64-QAM mapping
    % Each symbol -> 6 bits

    % Generate normalized 64-QAM constellation
    re = [-7 -5 -3 -1 1 3 5 7];
    im = [-7 -5 -3 -1 1 3 5 7];
    [Re, Im] = meshgrid(re, im);
    mapping = (Re(:) + 1j * Im(:)) / sqrt(42);  % normalization

    % Find nearest constellation point for each received symbol
    [~, idx] = min(abs(symbols(:) - mapping.'), [], 2); % idx: Nx1

    % Convert indices to bits (6 bits per symbol)
    bit_matrix = de2bi(idx - 1, 6, 'left-msb'); % Nx6

    % Reshape to row vector
    bits = reshape(bit_matrix.', 1, []);
end
