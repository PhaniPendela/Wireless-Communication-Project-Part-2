% Random bit generator to give input to QPSK modulator
% Generates a sequence of random bits of length N
function bits = random_bit_generator(N)
    % Input:
    %   N - Length of the bit sequence to generate
    % Output:
    %   bits - Generated random bit sequence (0s and 1s)
    bits = randi([0 1], 1, N);
end