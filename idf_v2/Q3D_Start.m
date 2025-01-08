function Res = Q3D_Start(visc, sizing, I, M_cr, h_cr)


%% Aerodynamic solver setting

% Wing planform geometry 
%                          x                              y                              z                          chord(m)        twist angle (deg) 
AC.Wing.Geom = [I.Wing(1).WingSection.Xle     I.Wing(1).WingSection.Yle     I.Wing(1).WingSection.Zle     I.Wing(1).WingSection.Chord         0;
                I.Wing(2).WingSection.Xle     I.Wing(2).WingSection.Yle     I.Wing(2).WingSection.Zle     I.Wing(2).WingSection.Chord         -6.5*0.2;
                I.Wing(3).WingSection.Xle     I.Wing(3).WingSection.Yle     I.Wing(3).WingSection.Zle     I.Wing(3).WingSection.Chord         -6.5];

% Wing incidence angle (degree)
AC.Wing.inc  = 4.5;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [cat(2,I.Wing(1).CST_Upper,I.Wing(1).CST_Lower);
                      cat(2,I.Wing(1).CST_Upper,I.Wing(1).CST_Lower);
                      cat(2,I.Wing(1).CST_Upper,I.Wing(1).CST_Lower)];
                  
AC.Wing.eta = [0;0.2;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = visc;              % 0 for inviscid and 1 for viscous analysis



MAC = 2/3*I.Wing(1).WingSection.Chord*(1+I.Wing(1).Taper+I.Wing(1).Taper^2)/(1+I.Wing(1).Taper);

% Flight Condition
AC.Aero.V     = M_cr*Utils.sound_speed(h_cr);            % flight speed (m/s)
AC.Aero.rho   = Utils.density(h_cr);         % air density  (kg/m3)
AC.Aero.alt   = h_cr;             % flight altitude (m)
AC.Aero.Re    = AC.Aero.rho*AC.Aero.V*MAC/Utils.viscosity(h_cr);        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = M_cr;           % flight Mach number 
if sizing==0
    AC.Aero.CL    = I.Weight.Design*9.8/(0.5*AC.Aero.rho*AC.Aero.V^2*I.Wing(1).Area);          % lift coefficient
else
    AC.Aero.CL    = I.n_max*I.Weight.MTOW*9.8/(0.5*AC.Aero.rho*AC.Aero.V^2*I.Wing(1).Area);          % lift coefficient
end
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
%tic

try 
Res = Q3D_solver(AC);
catch error
    CD = inf;
end

%Change in line 12 the x value for exercise 3
%t=toc
end