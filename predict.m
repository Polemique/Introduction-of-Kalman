
function [Znext] = predict(Zn, Xn, A, C, Gn)

    en = C' * Zn - Xn;
    Znext = A * Zn - Gn * en;
    
end

