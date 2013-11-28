function [ index ] = strlastindexof( s, c )
% String function last index of
%
%
% Parameters
% s: string where are looking for a char
% c: charater we are looking for
%
% Retunrs
% index of the charater, or -1 if we did not find it

index = -1;

strlen = length(s);

for i=[strlen:-1:1]
    if s(i) == c
        index = i;
        break;
    end
end

end

