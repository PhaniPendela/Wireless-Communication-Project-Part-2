% Error Rate Calculator function
function [numErrors, errorRate] = error_rate_calculator(transmittedBits, receivedBits)
    % Input:
    %   transmittedBits - Original transmitted bit sequence (0s and 1s)
    %   receivedBits - Received bit sequence after demodulation (0s and 1s)
    % Output:
    %   numErrors - Number of bit errors
    %   errorRate - Bit error rate (BER)
    numErrors = sum(transmittedBits ~= receivedBits);
    errorRate = numErrors / length(transmittedBits);
end