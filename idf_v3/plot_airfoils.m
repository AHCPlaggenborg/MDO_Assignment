% Array=readtable("airfoil_ref.dat");
% x1 = Array{:, 1};
% y1 = Array{:, 2};

Array2=readtable("withcomb135.dat");
x2 = Array2{:, 1};
y2 = Array2{:, 2};

%c = chord_distribution(1);

hold on
% plot(X0,Yust, '-b')
% plot(X0,Ylst, '-b')
% plot(X1,Yust.*c, '-r')
% plot(X1,Ylst.*c, '-r')
% plot(X_tank,Yust_interp.*c, '-b')
% plot(X_tank,Ylst_interp.*c, '-b')
X0 = linspace(0,1,100);
X = cat(2,X0,X0);
Y = cat(2,Yu,Yl);
plot(x2,y2.*0.1/0.1335,'-b');
plot(X0,Yu,'-r');
plot(X0,Yl,'-r');
legend('Original airfoil','Optimized airfoil')
grid on
%axis([0 1 -0.2 0.2])

