% Parameter description
%  1 = Width 
%  2 = ROB size
%  3 = IQ size
%  4 = LSQ size
%  5 = RF sizes
%  6 = RF read ports 
%  7 = RF write ports 
%  8 = Gshare size 
%  9 = BTB size 
% 10 = Branches allowed 
% 11 = L1 Icache size 
% 12 = L1 Dcache size 
% 13 = L2 Ucache size 
% 14 = Depth
% 15 = Delay in microseconds (Output)
%
% Input:
%   data        = m x 15 matrix containing the paramets as described above.
%                 Each line represents an observation.
%   v           = n x 2 matrix containing a pair of parameter numbers(1-15) to compare.
%                 The first parameter is placed on the x-axis and the second on the y-axis.
function compare( data, v )   
    
    n = size(v, 1);
    cc=hsv(n);               % color map to display multiple comparisons with different colors
    legendInfo = cell(1, n); % stores legend names
    figure();
    for i=1:n
        param_x = v(i,1);
        param_y = v(i,2);
        legendInfo{i} = [getParameterName(param_x) ' / ' getParameterName(param_y)];
        
        hold on
        plot(data(:,param_x), data(:,param_y), '+', 'color', cc(i,:));
    end
    legend(legendInfo);
end

