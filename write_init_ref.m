%%%_____Routine to write the input file for the EMWET procedure________% %%

namefile    =    char('A330_300');
MTOW        =    217000;         %[kg]
MZF         =    169000;         %[kg]
nz_max      =    2.5;   
span        =    60.3;            %[m]
root_chord =    10.56;           %[m]
kink_loc    =    0.2;            %percentage of half-span
taper       =    0.251;          
sweep_le    =    30;             %[deg]
sweep_te    =    5;              %[deg], inboard part
dihedral    =    5;              %[deg]
kink_chord  =    root_chord + kink_loc*span/2*(sind(sweep_te)-sind(sweep_le)); %[m]
spar_front  =    0.15;
spar_rear   =    0.60;
ftank_start =    0;
ftank_end   =    0.85;
eng_num     =    1;
eng_ypos    =    0.20;
eng_mass    =    5092;         %kg
E_al        =    7.0E10;       %N/m2
rho_al      =    2800;         %kg/m3
Ft_al       =    295.0E6;        %N/m2
Fc_al       =    295.0E6;        %N/m2
pitch_rib   =    0.5;          %[m]
eff_factor  =    0.96;             %Depend on the stringer type
Airfoil     =    'e553';
section_num =    3;
airfoil_num =    3;
wing_surf   =    (root_chord+kink_chord)*kink_loc*span/2+(kink_chord+root_chord*taper)*(1-kink_loc)*span/2;

fid = fopen( 'A330_300.init','wt');
fprintf(fid, '%g %g \n',MTOW,MZF);
fprintf(fid, '%g \n',nz_max);

fprintf(fid, '%g %g %g %g \n',wing_surf,span,section_num,airfoil_num);

fprintf(fid, '%g %s \n',0,Airfoil);
fprintf(fid, '%g %s \n',kink_loc,Airfoil);
fprintf(fid, '%g %s \n',1,Airfoil);
fprintf(fid, '%g %g %g %g %g %g \n',root_chord,0,0,0,spar_front,spar_rear);
fprintf(fid, '%g %g %g %g %g %g \n',root_chord + kink_loc*span/2*(sind(sweep_te)-sind(sweep_le)),kink_loc*span/2*sind(sweep_le),kink_loc*span/2,kink_loc*span/2*sind(dihedral),spar_front,spar_rear);
fprintf(fid, '%g %g %g %g %g %g \n',root_chord*taper,span/2*sind(sweep_le),span/2,span/2*sind(dihedral),spar_front,spar_rear);

fprintf(fid, '%g %g \n',ftank_start,ftank_end);

fprintf(fid, '%g \n', eng_num);
fprintf(fid, '%g  %g \n', eng_ypos,eng_mass);

fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);

fprintf(fid,'%g %g \n',eff_factor,pitch_rib)
fprintf(fid,'1 \n')
fclose(fid)