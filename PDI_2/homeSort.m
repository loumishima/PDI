function [out] = homesort(A)


A = sort(A);
out = A(ceil(size(A)/2));

end
