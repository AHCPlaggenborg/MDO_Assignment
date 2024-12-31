classdef Utils
    methods(Static)
        function rho = density(h)
            rho = 3.731e-14*h^3 + 5.669e-10*h^2 - 7.554e-05*h + 1.075;
        end

        function mu = viscosity(h)
            mu = 7.333e-18*h^3 - 2.03e-13*h^2 + 1.52e-09*h +1.235e-05;
        end

        function a = sound_speed(h)
            a = -0.004286*h + 342.4;
        end

        function [Yu,Yl] = D_airfoil(Au,Al,X)

            X = X';

            x = X(:,1);
            
            N1 = 0.5;   %Class function N1
            N2 = 1;     %Class function N2
            
            zeta_u = 0.000;     %upper surface TE gap
            zeta_l = -0.000;     %lower surface TE gap
            
            
            nu = length(Au)-1;
            nl = length(Al)-1;
            
            %evaluate required functions for each X-coordinate
            for i = 1:length(x)
            
            %calculate Class Function for x(i):
            C(i) = (x(i)^N1)*(1-x(i))^N2;
            
            %calculate Shape Functions for upper and lower surface at x(i)
            Su(i) = 0;  %Shape function initially zero
            for j = 0:nu
            Krnu = factorial(nu)/(factorial(j)*factorial(nu-j));
            Su(i) = Su(i) + Au(j+1)*Krnu*(1-x(i))^(nu-j)*x(i)^(j);
            end
            Sl(i) = 0;  %Shape function initially zero
            for k = 0:nl        
            Krnl = factorial(nl)/(factorial(k)*factorial(nl-k));
            Sl(i) = Sl(i) + Al(k+1)*Krnl*(1-x(i))^(nu-k)*x(i)^(k);
            end
            
            %calculate upper and lower surface ordinates at x(i)
            Yu(i) = C(i)*Su(i) + x(i)*zeta_u;
            Yl(i) = C(i)*Sl(i) + x(i)*zeta_l;
            
            %Thu(i) = C(i)*(Su(i)-Sl(i))/2;    %calculate thickness distribution !TE thickness ignored!
            %Thl(i) = C(i)*(Sl(i)-Su(i))/2;    %calculate thickness distribution !TE thickness ignored!
            %Cm(i) = C(i)*(Su(i)+Sl(i))/2;    %calculate camber distribution !TE thickness ignored!
            end
            
            %Yust = Yu';
            %Ylst = Yl';
            
            %assemble airfoil coord matrix
            %Xtu = [x  Yust];
            %Xtl = [x  Ylst];
        end

        function V_tank = tank_volume(I, Res)
            Y = linspace(0,I.Wing(1).Span/2,20);
            X0 = linspace(0,1,100);
            chord_distribution = interp1(Res.Wing.Yst, Res.Wing.chord, Y, 'spline');
            [Yust,Ylst] = Utils.D_airfoil(I.Wing(1).CST_Upper,I.Wing(1).CST_Lower,X0);
            for i=1:17 %from y=0 to y=0.85
                X1 = linspace(0,chord_distribution(i),100);
                X_tank = linspace(0.15*chord_distribution(i),0.60*chord_distribution(i),100);
                Yust = interp1(X1,Yust,X_tank);
                Ylst = interp1(X1,Ylst,X_tank);
                airfoil_surf(i) = chord_distribution(i)*trapz((0.6-0.15)*chord_distribution(i)/100,Yust - Ylst);
            end
            %disp(airfoil_surf)
            V_tank = 2*trapz(I.Wing(1).Span/(2*20),airfoil_surf);
        end
       
    end
end
