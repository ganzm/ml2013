function [ X_n ] = add_features_by_model( X, model )
   [m,n] = size(model);
   X_n = zeros(size(X,1),1);
   for j=1:m %m=14
    for k=1:n
        
        if(k==1 && model(j,k) == 1)% log regression
            X_n = [X_n log(X(:, j))];
        end
        if(k==2 && model(j,k) == 1)% square regression
            X_n = [X_n X(:, j).^2];
        end
        if(k==3 && model(j,k) == 1)% cube regression
            X_n = [X_n X(:, j).^2];
            X_n = [X_n X(:, j).^3];
        end
        if(k==4 && model(j,k) == 1)% linear regression
            X_n = [X_n X(:, j)];
        end
        if(k>4 && k <=18 && model(j,k) == 1)% log regression
            X_n = [X_n X(:, j).*X(:, k-4)];
        end
        if(k>18 && k <= 32 && model(j,k) == 1)% log regression
            X_n = [X_n X(:, j).*X(:, k-18).^3];
        end
       % if(k>32 && model(j,k) == 1)% log regression
       %     X = [X X(:, j).*X(:, k-32).^3];
       % end
        %if(model(i) == 4) % quad regression
        %    x = [x x(:, i).^2];
        %    x = [x x(:, i).^3];
        %    x = [x x(:, i).^4];
        %end
    end
   end
    
end