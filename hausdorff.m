
function [dH] = hausdorff( C1, C2)
% if(size(A,2) ~= size(B,2))
%     fprintf( 'Dimensionality must be the same\n' );
%     dH = [];
%     return;
% end
dH = max(compute_dist(C1, C2), compute_dist(C2, C1));

%% Compute distance
    function[dist] = compute_dist(C1, C2)
        m = size(C1, 1);
        n = size(C2, 1);
        dim= size(C1, 2);
        for k = 1:m
            C = ones(n, 1) * C1(k, :);
            D = (C-C2) .* (C-C2);
            D = sqrt(D * ones(dim,1));
            dist(k) = min(D);
        end
        dist = max(dist);
    end

end

