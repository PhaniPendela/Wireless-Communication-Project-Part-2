% 16-QAM Demodulator Function
function bits = qam_16_demodulator(symbols)
    % Input: symbols - Received noisy symbols (complex numbers)
    % Output: bits - Demodulated bit sequence (0s and 1s)

    % MAP the received symbols to the nearest constellation points
    % 16-QAM constellation points
    mapping = [-3-3j, -3-1j, -3+1j, -3+3j, -1-3j, -1-1j, -1+1j, -1+3j, 1-3j,  1-1j,  1+1j,  1+3j,  3-3j,  3-1j,  3+1j,  3+3j];

    % Find the nearest constellation point for each received symbol
    [~, idx] = min(abs(symbols(:) - mapping), [], 2);
    mapped_symbols = mapping(idx).';

    % Normalize the power of the symbols
    mapped_symbols = mapped_symbols * sqrt(10);

    % Initialize bit array
    num_symbols = length(mapped_symbols);
    bits = zeros(1, num_symbols * 4);

    for i = 1:num_symbols
        if isequal(mapped_symbols(i), -3-3j)
            bits(4*i-3:4*i) = [0 0 0 0];
        elseif isequal(mapped_symbols(i), -3-1j)
            bits(4*i-3:4*i) = [0 0 0 1];
        elseif isequal(mapped_symbols(i), -3+1j)
            bits(4*i-3:4*i) = [0 0 1 1];
        elseif isequal(mapped_symbols(i), -3+3j)
            bits(4*i-3:4*i) = [0 0 1 0];
        elseif isequal(mapped_symbols(i), -1-3j)
            bits(4*i-3:4*i) = [0 1 0 0];
        elseif isequal(mapped_symbols(i), -1-1j)
            bits(4*i-3:4*i) = [0 1 0 1];
        elseif isequal(mapped_symbols(i), -1+1j)
            bits(4*i-3:4*i) = [0 1 1 1];
        elseif isequal(mapped_symbols(i), -1+3j)
            bits(4*i-3:4*i) = [0 1 1 0];
        elseif isequal(mapped_symbols(i), 1-3j)
            bits(4*i-3:4*i) = [1 1 0 0];
        elseif isequal(mapped_symbols(i), 1-1j)
            bits(4*i-3:4*i) = [1 1 0 1];
        elseif isequal(mapped_symbols(i), 1+1j)
            bits(4*i-3:4*i) = [1 1 1 1];
        elseif isequal(mapped_symbols(i), 1+3j)
            bits(4*i-3:4*i) = [1 1 1 0];
        elseif isequal(mapped_symbols(i), 3-3j)
            bits(4*i-3:4*i) = [1 0 0 0];
        elseif isequal(mapped_symbols(i), 3-1j)
            bits(4*i-3:4*i) = [1 0 0 1];
        elseif isequal(mapped_symbols(i), 3+1j)
            bits(4*i-3:4*i) = [1 0 1 1];
        elseif isequal(mapped_symbols(i), 3+3j)
            bits(4*i-3:4*i) = [1 0 1 0];
        end
    end
end