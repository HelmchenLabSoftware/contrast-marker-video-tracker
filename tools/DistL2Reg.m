function rez = DistL2Reg(lst1, lst2)
    dx2 = 0.01 * double(lst1(1) - lst2(1))^2;          % Characteristic lscale = 10px
    dy2 = 0.01 * double(lst1(2) - lst2(2))^2;          % Characteristic lscale = 10px
    %dm2 = 2*log2(double(lst1(3)) / double(lst2(3)))^2; % Characteristic lscale = 2 times
    dm2 = 4 ^ abs(log2(double(lst1(3)) / double(lst2(3)))); % Characteristic lscale = 2 times
    rez = sqrt(dx2 + dy2 + dm2);
end