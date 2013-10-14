%Input:
%   parameter_number        = The number of the parameter (1-15)
%Output:
%   parameter_name          = The name of the parameter
function [ parameter_name ] = getParameterName( parameter_number )
    switch parameter_number
        case 1
            parameter_name = 'Width';
        case 2
            parameter_name = 'ROB size';
        case 3
            parameter_name = 'IQ size';
        case 4
            parameter_name = 'LSQ size';
        case 5
            parameter_name = 'RF sizes';
        case 6
            parameter_name = 'RF read ports';
        case 7
            parameter_name = 'RF write ports';
        case 8
            parameter_name = 'Gshare size';
        case 9
            parameter_name = 'BTB size';
        case 10
            parameter_name = 'Branches allowed';
        case 11
            parameter_name = 'L1 Icache size';
        case 12
            parameter_name = 'L1 Dcache size';
        case 13
            parameter_name = 'L2 Ucache size';
        case 14
            parameter_name = 'Depth';
        case 15
            parameter_name = 'Delay';            
        otherwise 
            warning('Unexpected paramer number');
    end
end

