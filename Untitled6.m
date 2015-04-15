      U = rand(100000,1);
      R = sqrt(-2*log(1-U));
      PHI = 2*pi*U;
      X = R.*cos(PHI);
      Y = R.*sin(PHI);

      figure(1);
      hist(X);
      figure(2);
      hist(Y);