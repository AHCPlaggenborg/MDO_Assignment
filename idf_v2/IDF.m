%Matlab IDF implementation of the Sellar problem (Sellar et
%al. 1996)
clear all
close all
clc

%Initial values: set everything to 1 (normalization) and multiply each
%variable by the reference values when using them in functions?
c_r = 1;
sweep_le = 1;
taper = 1;
span = 1;
%k_u = [0.2337    0.0796    0.2683    0.0887    0.2789    0.3811];
%k_l = [-0.2254   -0.1634  -0.0470   -0.4771    0.0735    0.3255];
k_u_1 = 1;
k_u_2 = 1;
k_u_3 = 1;
k_u_4 = 1;
k_u_5 = 1;
k_u_6 = 1;
k_l_1 = 1;
k_l_2 = 1;
k_l_3 = 1;
k_l_4 = 1;
k_l_5 = 1;
k_l_6 = 1;
M_cr = 1;
h_cr = 1;
W_wing_c = 1;
W_fuel_c = 1;
% CL_wing_c = 1;
% CD_wing_c = 1;
CLw_CDw_c = 1;

%bounds
lb = [0.75 0.15 0.4 0.75 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.9 0.95 0.6 0.6 0.8];
ub = [1.23 1.5 3.98 1.25 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.3 1.0413 1.1 1 1 1.2];

%lb = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0.7 0.7 0.80];
%ub = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1.2];

% x0 = [c_r sweep_le taper span k_u_1 k_u_2 k_u_3 k_u_4 k_u_5 k_u_6 k_l_1 k_l_2 k_l_3 k_l_4 k_l_5 k_l_6 M_cr h_cr W_wing_c W_fuel_c CL_wing_c CD_wing_c];
x0 = [c_r sweep_le taper span k_u_1 k_u_2 k_u_3 k_u_4 k_u_5 k_u_6 k_l_1 k_l_2 k_l_3 k_l_4 k_l_5 k_l_6 M_cr h_cr W_wing_c W_fuel_c CLw_CDw_c];

% Options for the optimization
% options.Display         = 'iter-detailed';
% options.Algorithm       = 'sqp';
% options.FunValCheck     = 'off';
% options.DiffMinChange   = 1e-6;         % Minimum change while gradient searching
% options.DiffMaxChange   = 5e-2;         % Maximum change while gradient searching
% options.TolCon          = 1e-6;         % Maximum difference between two subsequent constraint vectors [c and ceq]
% options.TolFun          = 1e-10;         % Maximum difference between two subsequent objective value
% options.TolX            = 1e-10;         % Maximum difference between two subsequent design vectors
% %options.DiffMinChange   = 0.01;
% "PlotFcn",{@optimplotfval,@plotconstraints,@plotconstraintseq};
% 
% options.MaxIter         = 30;           % Maximum iterations
options = optimoptions("fmincon", "Algorithm","sqp", "Display","iter-detailed","FunValCheck","off","ScaleProblem",false,"PlotFcn",{@optimplotfval,@plotconstraints,@plotconstraintseq},"DiffMinChange",2e-3,"DiffMaxChange",5e-1,"TolCon",0.0118,"TolFun",1e-6,"TolX",1e-6,"MaxIter",1000,"FiniteDifferenceType","central");

tic;
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@(x) Optim_IDF(x),x0,[],[],[],[],lb,ub,@(x) constraints_IDF(x),options);
toc;

%optionally, call the objective again with the optimum values for x
[f,vararg] = Optim_IDF(x);
f = 3.16*79957*f;
