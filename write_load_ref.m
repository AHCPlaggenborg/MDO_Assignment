%%%_____Routine to write the load file for the EMWET procedure________% %%

namefile    =    char('A330_300.load');
%n=14;
fid = fopen( 'A330_300.load','wt');
%y=Res.Wing.Yst;
half_span=60.3/2; %[m]
%cl=Res.Wing.ccl;
%cm=Res.Wing.cm_c4;
AC.Aero.V     = 257.32;            % flight speed (m/s)
AC.Aero.rho   = 0.40973;         % air density  (kg/m3)
AC.Aero.alt   = 10058.4;             % flight altitude (m)
AC.Aero.Re    = 52176845;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.86;           % flight Mach number 
AC.Aero.CL    = 2.5*217000*9.8/(0.5*AC.Aero.rho*AC.Aero.V^2*((10.56+8.07)*0.1*60.3/2+(8.07+2.65)*0.4*60.3/2));
span        =    60.3;            %[m]
root_chord =    10.56;           %[m]
kink_loc    =    0.2;
taper       =    0.251;          
sweep_le    =    30;             %[deg]
sweep_te    =    5;              %[deg], inboard part
kink_chord  =    root_chord + kink_loc*span/2*(sind(sweep_te)-sind(sweep_le)); %[m]
wing_surf   =    (root_chord+kink_chord)*kink_loc*0.5*span/2+(kink_chord+root_chord*taper)*(1-kink_loc)*0.5*span/2;
q=0.5*AC.Aero.rho*AC.Aero.V^2;
y=linspace(0,1,20);
L=interp1(Res.Wing.Yst,Res.Wing.ccl*q,y*span/2,'spline'); %lift distribution
T=interp1(Res.Wing.Yst,Res.Wing.cm_c4.*Res.Wing.chord*q*7.26,y*span/2,'spline'); %pitching moment distribution
n=20;
for k=1:n
%fprintf(fid, '%g %g %g \n',y(k)/half_span,0.5*AC.Aero.rho*AC.Aero.V^2*wing_surf*cl(k),0.5*AC.Aero.rho*AC.Aero.V^2*wing_surf*7.26*cm(k));
fprintf(fid, '%g %g %g \n',y(k),L(k),T(k));
end
%C = wing cord distribution (L=ClxC)
fclose(fid)