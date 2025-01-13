function Wfuel = Performance(I, M_cr, h_cr, CLw_CDw, CLw)

%CD_AW = 0.01267;
%CD_AW = 0.010956;
CD_AW = 0.0138125;
V = M_cr*Utils.sound_speed(h_cr); %m/s
R = 8334000; %m, calculated from design range of 4500 NM
nu = exp(-(V-239.217)^2/(2*70^2) - (h_cr-10058.4)^2/(2*2500^2));
CT = 1.8639e-4/nu;
%CL_CD = CL_w/(CD_w + CD_AW);
%CL_CD = 16;
CL_CD = 1/(CD_AW/CLw + 1/CLw_CDw);
K = 1-0.938*exp(-R*CT/(V*CL_CD));
Wfuel = K*I.Weight.MTOW;

end
