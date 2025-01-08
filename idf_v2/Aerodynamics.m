function Res_aero = Aerodynamics(I, M_cr, h_cr)

visc=1;
sizing=0;
Res_aero = Q3D_Start(visc, sizing, I, M_cr, h_cr);
%CL_CD = Res_aero.CLwing/Res_aero.CDwing;

end