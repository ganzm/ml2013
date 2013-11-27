function [ result ] = levensteindistance( s, t )
% calculates the distance between two strings
% http://en.wikipedia.org/wiki/Levenshtein_distance


% len_s and len_t are the number of characters in string s and t respectively
len_s = length(s);
len_t = length(t);

% test for degenerate cases of empty strings
if (len_s == 0)
    result = len_t;
    return;
end
if (len_t == 0) 
    result = len_s;
    return;
end
  
% test if last characters of the strings match
if  s(len_s) == t(len_t)
    cost = 0;
else
    cost = 1;
end

% return minimum of delete char from s, delete char from t, and delete char from both */

t1 = levensteindistance(s(1:end-1), t) + 1;
t2 = levensteindistance(s, t(1:end-1)) + 1;
t3 = levensteindistance(s(1:end-1), t(1:end-1)) + cost;


result = min([t1, t2, t3]);

end

