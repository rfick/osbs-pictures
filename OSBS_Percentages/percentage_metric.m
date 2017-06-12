function [difference] = percentage_metric(abundances1, abundances2)
%PERCENTAGE_METRIC compares 2 abundance estimates and gives a difference
%
% Inputs:
%  abundances1 - 5x1 array of abundance estimates
%  abundances2 - 5x1 array of abundance estimates
%
% Outputs:
%  difference - scalar comparing how different the abundances are

difference = 0;
difference = difference + abs(abundances1(1) - abundances2(1));
difference = difference + abs(abundances1(2) - abundances2(2));
difference = difference + abs(abundances1(3) - abundances2(3));
difference = difference + abs(abundances1(4) - abundances2(4));
difference = difference + abs(abundances1(5) - abundances2(5));

difference = difference/2;

end