
function [Gnext, Pnext] = update_filter(Gn, Pn, C, A, Qb, Qv)
    
    Pnext = A * (Pn - Gn * C' * Pn) * A' + Qv;
    Gnext = (Pnext * C) / (C' * Pnext * C + Qb);

end

