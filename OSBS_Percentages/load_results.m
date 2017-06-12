function [results] = load_results(varargin)
%LOAD_RESULTS loads the results in a file into a matlab structure
%
% Inputs:
%  filename - string of filename to load results from
%  results (optional) - results structure to append new results onto
%
% Outputs:
%  results - cell array containing results

if(nargin < 1)
    error('Not enough input arguments!');
elseif(nargin > 2)
    error('Too many input arguments!');
end

filename = varargin{1};
if(nargin == 2)
    results = varargin{2};
else
    results = [];
end

fileID = fopen(filename);

tline = fgetl(fileID);
while ischar(tline)
    C = strsplit(tline, '\t');
    C = [C, filename];
    
    results = [results; C];
    
    tline = fgetl(fileID);
end

fclose(fileID);

end