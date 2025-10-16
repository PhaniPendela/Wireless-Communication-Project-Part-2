% BPSK Demodulator Function
function bits = bpsk_demodulator(symbols)
    % Input: symbols - Received noisy symbols (real numbers)
    % Output: bits - Demodulated bit sequence (0s and 1s)

    % MAP the received symbols to the nearest constellation points
    % BPSK constellation points
    mapping = [-1 + 0j, 1 + 0j];
    % Find the nearest constellation point for each received symbol
    [~, idx] = min(abs(symbols(:) - mapping), [], 2);
    mapped_symbols = mapping(idx).';

    % Normalize the power of the symbols
    mapped_symbols = mapped_symbols * sqrt(2/3);

    % Map BPSK symbols to bits
    bits = (mapped_symbols + 1) / 2; % Maps -1 -> 0 and 1 -> 1
end