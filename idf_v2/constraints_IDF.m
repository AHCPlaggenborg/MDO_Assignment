function [c,ceq] = constraints_IDF(x)
%function computing constraints of the sellar problem
global couplings;
 
W_wing = couplings.W_wing;
W_fuel = couplings.W_fuel;
% CL_wing = couplings.CL_wing;
% CD_wing = couplings.CD_wing;
CLw_CDw = couplings.CLw_CDw;
I = couplings.I;
Res_aero = couplings.Res_aero;

% W_wing_c = x(19);
% W_fuel_c = x(20);
% CL_wing_c = x(21);
% CD_wing_c = x(22);

cc1 = (W_wing/(x(19)*42786) - 1);
cc2 = (W_fuel/(x(20)*70000) - 1);
% cc3 = (CL_wing/(x(21)*0.4649) - 1);
% cc4 = (CD_wing/(x(22)*0.0150) - 1);
cc3 = (CLw_CDw/(x(21)*31) - 1);

W_AW = 100000;
c1 = (W_wing + W_AW + W_fuel)/217000 - 1; %MTOW, W_AW to be defined
%c2 = x(17)*0.82*Utils.sound_speed(x(18)*10058.4)/(0.86*Utils.sound_speed(10058.4)) - 1; %VMO, M bounds need to be changed 
c3 = (W_wing + W_AW + W_fuel)/I.Wing(1).Area/(217000/363.1) - 1; %Wing Loading
c4 = W_fuel/817.15/(Utils.tank_volume(I, Res_aero)*0.93) - 1;
% c = [c1,c2,c3,c4];
c = [c1,c3,c4]
% ceq = [cc1,cc2,cc3,cc4];
ceq = [cc1,cc2,cc3]
end