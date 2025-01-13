function [f,vararg] = Optim_IDF(x)
    c_r = x(1)*11.56;
    sweep_le = x(2)*35;
    taper = x(3)*0.251;
    span = x(4)*60.3;
    k_u_1 = x(5)*0.1757;
    k_u_2 = x(6)*0.0599;
    k_u_3 = x(7)*0.2015;
    k_u_4 = x(8)*0.0669;
    k_u_5 = x(9)*0.2095;
    k_u_6 = x(10)*0.2867;
    k_u = [k_u_1 k_u_2 k_u_3 k_u_4 k_u_5 k_u_6];
    k_l_1 = x(11)*(-0.1695);
    k_l_2 = x(12)*(-0.1230);
    k_l_3 = x(13)*(-0.0352);
    k_l_4 = x(14)*(-0.3590);
    k_l_5 = x(15)*0.0555;
    k_l_6 = x(16)*0.2446;
    k_l = [k_l_1 k_l_2 k_l_3 k_l_4 k_l_5 k_l_6];
    M_cr = x(17)*0.80; %reference value
    %h_cr = x(18)*10058.4;
    h_cr = x(18)*10058.4;

    %Initial guess for output of discipline 2
    %W_wing_c = x(19)*42786; %to be multiplied by reference value
    %W_fuel_c = x(20)*79957; %to be multiplied by reference value
    % CL_wing_c = x(21)*0.4649; %to be multiplied by reference value
    % CD_wing_c = x(22)*0.0150; %to be multiplied by reference value
    %CLw_CDw_c = x(21)*31;
    %W_wing_c = x(19)*42081;
    % W_wing_c = x(19)*40768; %after correction in Loads_Structure (V^2)
    % W_fuel_c = x(20)*66718;
    % CLw_CDw_c = x(21)*33;
    % W_wing_c = x(19)*38157; %given by Loads_Structure
    % W_fuel_c = x(20)*78683; %given by Performance, MTOW = 210000 ==> fuel = 80896
    % CLw_CDw_c = x(21)*31.838; %given by Aerodynamics
    W_wing_c = x(19)*42331.892; %given by all 1 optim
    W_fuel_c = x(20)*78682.81; %given by all 1 optim
    CLw_CDw_c = x(21)*33.0895; %given by all 1 optim
    
    I = Initiator(c_r, sweep_le, taper, span, k_u, k_l, W_wing_c, W_fuel_c);
    W_wing = Loads_Structure(I, M_cr, h_cr);
    Res_aero = Aerodynamics(I, M_cr, h_cr);
    % CL_wing = Res_aero.CLwing;
    % CD_wing = Res_aero.CDwing;
    % CD_wing = fillmissing(CD_wing,'constant',0.0150);
    % W_fuel = Performance(I, M_cr, h_cr, CL_wing_c, CD_wing_c);
    CLw_CDw = Res_aero.CLwing/Res_aero.CDwing;
    CLw_CDw = fillmissing(CLw_CDw,'constant',5);
    W_fuel = Performance(I, M_cr, h_cr, CLw_CDw, Res_aero.CLwing);

    f = 3.16*W_fuel/(3.16*78682.81); %normalized objective function
    
      
    global couplings;
    
    % vararg = {W_wing, W_fuel, CL_wing, CD_wing,W_wing_c, W_fuel_c, CL_wing_c, CD_wing_c, I};
    vararg = {W_wing, W_fuel, CLw_CDw, W_wing_c, W_fuel_c, CLw_CDw_c, I};
    couplings.W_wing = W_wing;
    couplings.W_fuel = W_fuel;
    % couplings.CL_wing = CL_wing;
    %couplings.CD_wing = CD_wing;
    couplings.CLw_CDw = CLw_CDw;
    couplings.I = I;
    couplings.Res_aero = Res_aero;
    
end