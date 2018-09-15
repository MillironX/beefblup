% uniquenan
% Serves the same purpose as UNIQUE, but ensures any NaN fields are not
% counted
function y = uniquenan(x)
y = unique(x);
if any(isnan(y))
    y(isnan(y)) = [];
    y(end + 1) = NaN;
end
end