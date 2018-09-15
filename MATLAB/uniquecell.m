% uniquenan
% Serves the same purpose as UNIQUE, but ensures any empty cells are not
% counted
function y = uniquecell(x)
y = unique(x);
if any(cellfun(@isempty, y))
    y(cellfun(@isempty, y)) = [];
end
end