function index = find_closest(array, val)
    f = abs(array - val);
    [~, index] = min(f);    
end