
clear all
close all
clc


%% Aerodynamic solver setting

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0     0     0     11.56        0;
                0.2*60.3/2*tand(35)  0.2*60.3/2   0.2*60.3/2*tand(8)     8.63         -4*0.2;
                60.3/2*tand(35)  60.3/2   60.3/2*tand(8)     2.65         -6.5];

% Wing incidence angle (degree)
AC.Wing.inc  = 3;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
% AC.Wing.Airfoils   = [0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255;
%                       0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255;
%                       0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255];

% AC.Wing.Airfoils   = [0.1246 0.1445 0.1507 0.2118 0.1773 0.2069 -0.1321 -0.1179 -0.2187 -0.1269 -0.0806 0.0511;
%                       0.1246 0.1445 0.1507 0.2118 0.1773 0.2069 -0.1321 -0.1179 -0.2187 -0.1269 -0.0806 0.0511;
%                       0.1246 0.1445 0.1507 0.2118 0.1773 0.2069 -0.1321 -0.1179 -0.2187 -0.1269 -0.0806 0.0511];

% AC.Wing.Airfoils   = [0.1751 0.0597 0.2008 0.0667 0.2087 0.2856 -0.1688 -0.1225 -0.0350 -0.3576 0.0553 0.2437;
%                       0.1751 0.0597 0.2008 0.0667 0.2087 0.2856 -0.1688 -0.1225 -0.0350 -0.3576 0.0553 0.2437;
%                       0.1751 0.0597 0.2008 0.0667 0.2087 0.2856 -0.1688 -0.1225 -0.0350 -0.3576 0.0553 0.2437];

AC.Wing.Airfoils   = [0.1757 0.0599 0.2015 0.0669 0.2095 0.2867 -0.1695 -0.1230 -0.0352 -0.3590 0.0555 0.2446;
                      0.1757 0.0599 0.2015 0.0669 0.2095 0.2867 -0.1695 -0.1230 -0.0352 -0.3590 0.0555 0.2446;
                      0.1757 0.0599 0.2015 0.0669 0.2095 0.2867 -0.1695 -0.1230 -0.0352 -0.3590 0.0555 0.2446];

AC.Wing.eta = [0;0.2;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis
%AC.Aero.MaxIterIndex = 150;

MAC = 2/3*11.56*(1+0.251+0.251^2)/(1+0.251);

% Flight Condition
%AC.Aero.V     = 257.32;            % flight speed (m/s)
AC.Aero.alt   = 10058.4;             % flight altitude (m)
AC.Aero.rho   = Utils.density(AC.Aero.alt);         % air density  (kg/m3)
%AC.Aero.Re    = 5.31e7;        % reynolds number (based on mean aerodynamic chord)
AC.Aero.M     = 0.85;           % flight Mach number 
AC.Aero.V     = AC.Aero.M*Utils.sound_speed(AC.Aero.alt);
AC.Aero.Re    = AC.Aero.rho*AC.Aero.V*MAC/Utils.viscosity(AC.Aero.alt);

span        =    60.3;            %[m]
root_chord =    11.56;           %[m]
kink_loc    =    0.2;
taper       =    0.251;          
sweep_le    =    35;             %[deg]
sweep_te    =    8;              %[deg], inboard part
kink_chord  =    root_chord + kink_loc*span/2*(sind(sweep_te)-sind(sweep_le)); %[m]
wing_surf   =    (root_chord+kink_chord)*kink_loc*0.5*span/2+(kink_chord+root_chord*taper)*(1-kink_loc)*0.5*span/2; %half wing
q=0.5*AC.Aero.rho*AC.Aero.V^2;
AC.Aero.CL    = 2.5*210000*9.8/(q*2*wing_surf);          % lift coefficient - comment this line to run the code for given alpha%
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
%tic

try 
Res = Q3D_solver(AC)
catch error
    CD = inf;
end

hold on
plot(Res.Section.Y,Res.Section.Cd, '-r')
plot(Res.Section.Y,Res.Section.Cl, '-b')
grid on

%Change in line 12 the x value for exercise 3
%t=toc