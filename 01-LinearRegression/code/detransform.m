function [ Y ] = detransform( Y_trans, parameter )
    Y = Y_trans .* parameter.var + parameter.mean;
end

