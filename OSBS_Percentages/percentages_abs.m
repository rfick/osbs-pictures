function [differences] = percentages_abs(abundances1, abundances2)
%PERCENTAGE_METRIC compares 2 abundance estimates and gives a difference
%
% Inputs:
%  abundances1 - 5x1 array of abundance estimates
%  abundances2 - 5x1 array of abundance estimates
%
% Outputs:
%  difference - scalar comparing how different the abundances are

differences = zeros(5, 1);
differences(1) = abs(abundances1(1) - abundances2(1));
differences(2) = abs(abundances1(2) - abundances2(2));
differences(3) = abs(abundances1(3) - abundances2(3));
differences(4) = abs(abundances1(4) - abundances2(4));
differences(5) = abs(abundances1(5) - abundances2(5));

end