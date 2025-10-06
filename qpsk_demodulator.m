% QPSK Demodulator function
function bits = qpsk_demodulator(symbols)
    % Input:
    %   symbols - Received noisy symbols (complex numbers)
    % Output:
    %   bits - Demodulated bit sequence (0s and 1s)

    % MAP the received symbols to the nearest constellation points
    % QPSK constellation points
    mapping = [1+1j, -1+1j, -1-1j, 1-1j];
    % Create a decision boundary
    % Find the nearest constellation point for each received symbol
    [~, idx] = min(abs(symbols.' - mapping), [], 2);
    mapped_symbols = mapping(idx).';

    % Normalize the power of the symbols
    mapped_symbols = mapped_symbols * sqrt(2);

    % Initialize bit array
    num_symbols = length(mapped_symbols);
    bits = zeros(1, num_symbols * 2);

    for i = 1:num_symbols
        if real(mapped_symbols(i)) > 0 && imag(mapped_symbols(i)) > 0
            bits(2*i-1:2*i) = [0 0]; % Symbol 1+1j
        elseif real(mapped_symbols(i)) < 0 && imag(mapped_symbols(i)) > 0
            bits(2*i-1:2*i) = [0 1]; % Symbol -1+1j
        elseif real(mapped_symbols(i)) < 0 && imag(mapped_symbols(i)) < 0
            bits(2*i-1:2*i) = [1 1]; % Symbol -1-1j
        elseif real(mapped_symbols(i)) > 0 && imag(mapped_symbols(i)) < 0
            bits(2*i-1:2*i) = [1 0]; % Symbol 1-1j
        end
    end
end