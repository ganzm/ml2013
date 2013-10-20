function [ Y_trans, parameter ] = transform( Y )

[Y_trans, mean, var] = normalize(Y);

parameter.mean = mean;
parameter.var = var;

Y_trans = Y;

end

