% BPSK Modulator Function
function symbols = bpsk_modulator(bits)
    % Input: bits - A binary vector (0s and 1s)
    % Output: symbols - A vector of BPSK symbols (-1 and 1)

    % Validate input
    if ~isvector(bits) || ~all(ismember(bits, [0 1]))
        error('Input must be a binary vector containing only 0s and 1s.');
    end

    % Map bits to BPSK symbols
    symbols = 2*bits - 1; % Maps 0 -> -1 and 1 -> 1

    % Normalize the power of the symbols
    symbols = symbols / sqrt(2/3); % Normalization factor for BPSK
end