% 64-QAM Demodulator Function
function bits = qam_64_demodulator(symbols)
    % Input: symbols - Received noisy symbols (complex numbers)
    % Output: bits - Demodulated bit sequence (0s and 1s)

    % MAP the received symbols to the nearest constellation points
    % 64-QAM constellation points
    mapping = [-7-7j, -7-5j, -7-3j, -7-1j, -7+1j, -7+3j, -7+5j, -7+7j, -5-7j, -5-5j, -5-3j, -5-1j, -5+1j, -5+3j, -5+5j, -5+7j, -3-7j, -3-5j, -3-3j, -3-1j, -3+1j, -3+3j, -3+5j, -3+7j, -1-7j, -1-5j, -1-3j, -1-1j, -1+1j, -1+3j, -1+5j, -1+7j, 1-7j,  1-5j,  1-3j,  1-1j,  1+1j,  1+3j,  1+5j,  1+7j, 3-7j,  3-5j,  3-3j,  3-1j,  3+1j,  3+3j,  3+5j,  3+7j, 5-7j, 5-5j, 5-3j,  5-1j,  5+1j,  5+3j,  5+5j,  5+7j, 7-7j,  7-5j,  7-3j,  7-1j,  7+1j,  7+3j,  7+5j,  7+7j];

    % Find the nearest constellation point for each received symbol
    [~, idx] = min(abs(symbols(:) - mapping), [], 2);
    mapped_symbols = mapping(idx).';

    % Normalize the power of the symbols
    mapped_symbols = mapped_symbols * sqrt(42);

    % Map 64-QAM symbols to bits
    bits = de2bi(find(mapped_symbols == mapping) - 1, 6, 'left-msb');
    bits = bits(:);
end