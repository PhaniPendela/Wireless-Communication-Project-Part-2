% 16-QAM Modulator Function
function symbols = qam_16_modulator(bits)
    % Input: bits - A binary vector (0s and 1s) of length multiple of 4
    % Output: symbols - A vector of 16-QAM symbols (complex numbers)

    % Validate input
    if ~isvector(bits) || mod(length(bits), 4) ~= 0 || ~all(ismember(bits, [0 1]))
        error('Input must be a binary vector of length multiple of 4 containing only 0s and 1s.');
    end

    % Reshape bits into groups of 4
    bits_reshaped = reshape(bits, 4, []).';

    % Map each group of 4 bits to a 16-QAM symbol
    % Define the mapping for 16-QAM
    mapping = [-3-3j, -3-1j, -3+1j, -3+3j, -1-3j, -1-1j, -1+1j, -1+3j, 1-3j,  1-1j,  1+1j,  1+3j,  3-3j,  3-1j,  3+1j,  3+3j];
    symbols = zeros(1, size(bits_reshaped, 1));

    for i = 1:size(bits_reshaped, 1)
        bit_pair = bits_reshaped(i, :);
        if isequal(bit_pair, [0 0 0 0])
            symbols(i) = mapping(1);
        elseif isequal(bit_pair, [0 0 0 1])
            symbols(i) = mapping(2);
        elseif isequal(bit_pair, [0 0 1 1])
            symbols(i) = mapping(3);
        elseif isequal(bit_pair, [0 0 1 0])
            symbols(i) = mapping(4);
        elseif isequal(bit_pair, [0 1 0 0])
            symbols(i) = mapping(5);
        elseif isequal(bit_pair, [0 1 0 1])
            symbols(i) = mapping(6);
        elseif isequal(bit_pair, [0 1 1 1])
            symbols(i) = mapping(7);
        elseif isequal(bit_pair, [0 1 1 0])
            symbols(i) = mapping(8);
        elseif isequal(bit_pair, [1 1 0 0])
            symbols(i) = mapping(9);
        elseif isequal(bit_pair, [1 1 0 1])
            symbols(i) = mapping(10);
        elseif isequal(bit_pair, [1 1 1 1])
            symbols(i) = mapping(11);
        elseif isequal(bit_pair, [1 1 1 0])
            symbols(i) = mapping(12);
        elseif isequal(bit_pair, [1 0 0 0])
            symbols(i) = mapping(13);
        elseif isequal(bit_pair, [1 0 0 1])
            symbols(i) = mapping(14);
        elseif isequal(bit_pair, [1 0 1 1])
            symbols(i) = mapping(15);
        elseif isequal(bit_pair, [1 0 1 0])
            symbols(i) = mapping(16);
        end
    end

    % Normalize the power of the symbols
    symbols = symbols / sqrt(10); % Normalization factor for 16-QAM
end