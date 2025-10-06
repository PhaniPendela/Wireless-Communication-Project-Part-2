% QPSK modulator function
function symbols = qpsk_modulator(bits)
    % Input:
    %   bits - Input bit sequence (0s and 1s)
    % Output:
    %   symbols - Modulated QPSK symbols (complex numbers)

    % Ensure the input length is even
    if mod(length(bits), 2) ~= 0
        error('Input bit sequence length must be even for QPSK modulation.');
    end

    % Reshape bits into pairs
    bit_pairs = reshape(bits, 2, []).';

    % Map bit pairs to QPSK symbols
    mapping = [1+1j, -1+1j, -1-1j, 1-1j]; % QPSK constellation points
    symbols = zeros(1, size(bit_pairs, 1));

    for i = 1:size(bit_pairs, 1)
        if isequal(bit_pairs(i, :), [0 0])
            symbols(i) = mapping(1);
        elseif isequal(bit_pairs(i, :), [0 1])
            symbols(i) = mapping(2);
        elseif isequal(bit_pairs(i, :), [1 1])
            symbols(i) = mapping(3);
        elseif isequal(bit_pairs(i, :), [1 0])
            symbols(i) = mapping(4);
        end
    end

    % Normalize the power of the symbols
    symbols = symbols / sqrt(2);
end