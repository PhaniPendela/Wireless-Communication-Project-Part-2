% 64-QAM Modulator Function
function symbols = qam_64_modulator(bits)
    % Input: bits - A binary vector (0s and 1s) of length multiple of 6
    % Output: symbols - A vector of 64-QAM symbols (complex numbers)

    % Validate input
    if ~isvector(bits) || mod(length(bits), 6) ~= 0 || ~all(ismember(bits, [0 1]))
        error('Input must be a binary vector of length multiple of 6 containing only 0s and 1s.');
    end

    % Reshape bits into groups of 6
    bits_reshaped = reshape(bits, 6, []).';

    % Map each group of 6 bits to a 64-QAM symbol
    % Define the mapping for 64-QAM
    mapping = [-7-7j, -7-5j, -7-3j, -7-1j, -7+1j, -7+3j, -7+5j, -7+7j, -5-7j, -5-5j, -5-3j, -5-1j, -5+1j, -5+3j, -5+5j, -5+7j, -3-7j, -3-5j, -3-3j, -3-1j, -3+1j, -3+3j, -3+5j, -3+7j, -1-7j, -1-5j, -1-3j, -1-1j, -1+1j, -1+3j, -1+5j, -1+7j, 1-7j,  1-5j,  1-3j,  1-1j,  1+1j,  1+3j,  1+5j,  1+7j, 3-7j,  3-5j,  3-3j,  3-1j,  3+1j,  3+3j,  3+5j,  3+7j, 5-7j, 5-5j, 5-3j,  5-1j,  5+1j,  5+3j,  5+5j,  5+7j, 7-7j,  7-5j,  7-3j,  7-1j,  7+1j,  7+3j,  7+5j,  7+7j];
    symbols = zeros(1, size(bits_reshaped, 1));

    for i = 1:size(bits_reshaped, 1)
        bit_group = bits_reshaped(i, :);
        index = bi2de(bit_group, 'left-msb') + 1; % Convert bits to decimal index (1-64)
        symbols(i) = mapping(index);
    end

    % Normalize the power of the symbols
    symbols = symbols / sqrt(42); % Normalization factor for 64-QAM
end