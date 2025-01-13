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

cc1 = (W_wing/(x(19)*42331.892) - 1);
cc2 = (W_fuel/(x(20)*78682.81) - 1);
cc3 = (CLw_CDw/(x(21)*33.0895) - 1);

W_AW = 93000; %MTOW - Wwing_init - Wfuel_init
c1 = (W_wing + W_AW + W_fuel)/217000 - 1; %MTOW, W_AW to be defined
c2 = (W_wing + W_AW + W_fuel)/I.Wing(1).Area/(217000/363.1) - 1; %Wing Loading
c3 = W_fuel/817.15/(Utils.tank_volume(I, Res_aero)*0.93) - 1;
c = [c1,c2,c3]
ceq = [cc1,cc2,cc3]
end