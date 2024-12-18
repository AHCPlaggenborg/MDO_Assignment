
clear all
close all
clc


%% Aerodynamic solver setting

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0     0     0     10.56         0;
                0.1*60.3*sind(30)  0.1*60.3   0.1*60.3*sind(5)     8.07         -6.5*0.2;
                0.5*60.3*sind(30)  0.5*60.3   0.5*60.3*sind(5)     2.65         -6.5];

% Wing incidence angle (degree)
AC.Wing.inc  = 4.5;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255;
                      0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255;
                      0.2337    0.0796    0.2683    0.0887    0.2789    0.3811  -0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255];
                  
AC.Wing.eta = [0;0.2;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
AC.Aero.V     = 257.32;            % flight speed (m/s)
AC.Aero.rho   = 0.40973;         % air density  (kg/m3)
AC.Aero.alt   = 10058.4;             % flight altitude (m)
AC.Aero.Re    = 52176845;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.86;           % flight Mach number 
AC.Aero.CL    = 2.5*217000*9.8/(0.5*AC.Aero.rho*AC.Aero.V^2*((10.56+8.07)*0.1*60.3/2+(8.07+2.65)*0.4*60.3/2));          % lift coefficient - comment this line to run the code for given alpha%
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
tic

try 
Res = Q3D_solver(AC);
catch error
    CD = inf;
end

%Change in line 12 the x value for exercise 3
t=toc