function [c,ceq] = constraints_IDF(x)
%function computing constraints of the sellar problem
global couplings;
 
couplings.W_wing = W_wing;
couplings.W_fuel = W_fuel;
couplings.CL_wing = CL_wing;
couplings.CD_wing = CD_wing;

% W_wing_c = x(19);
% W_fuel_c = x(20);
% CL_wing_c = x(21);
% CD_wing_c = x(22);

cc1 = (W_wing-x(19));
cc2 = (W_fuel-x(20));
cc3 = (CL_wing-x(21));
cc4 = (CD_wing-x(22));

c1 = (W_wing + W_AW + W_fuel) - 217000; %MTOW, W_AW to be defined
c2 = x(17)*Utils.sound_speed(x(18)) - 0.86*Utils.sound_speed(10058.4); %VMO, M bounds need to be changed 
c3 = (W_wing + W_AW + W_fuel)/I.Wing(1).Area - 217000/363.1; %Wing Loading
c4 = W_fuel/817.15 - Utils.tank_volume()*0.93;
c = [c1,c2];
ceq = [cc1,cc2];
end