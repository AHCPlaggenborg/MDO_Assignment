function I=Initiator(c_r, sweep_le, taper, span, k_u, k_l, W_str, W_fuel)


%% Design Weight
%W_AW = 124874; % A-W, defined as ZFW_ref - Wstr
W_AW = 100000; % A-W, defined as MTOW_ref - Wstr - Wfuel

I.Weight.MTOW = W_str + W_AW + W_fuel;
I.Weight.ZFW = W_str + W_AW;
I.Weight.Design = sqrt((W_str + W_AW + W_fuel)*(W_str + W_AW));
% I.Weight.MTOW = 217000;
% I.Weight.ZFW = 169000;
I.n_max = 2.5;

%% Wing geometry

c_k = c_r + 0.2*span/2*(sind(5)-sind(sweep_le)); %[m]
I.Wing(1).Taper = taper;
I.Wing(1).CST_Upper = k_u;
I.Wing(1).CST_Lower = k_l;
I.Wing(1).Area = (c_r+c_k)*0.2*span/2+(c_k+c_r*taper)*(1-0.2)*span/2;
I.Wing(1).Span = span;
I.Wing(1).SectionNumber = 3;
I.Wing(1).AirfoilNumber = 3;

I.Wing(1).AirfoilName = "airfoil";
I.Wing(1).AirfoilPosition = [0 0.2 1];


% section 1

I.Wing(1).WingSection.Chord = c_r;
I.Wing(1).WingSection.Xle = 0;
I.Wing(1).WingSection.Yle = 0;
I.Wing(1).WingSection.Zle = 0;
I.Wing(1).WingSection.FrontSparPosition = 0.15;
I.Wing(1).WingSection.RearSparPosition = 0.60;


% section 2

I.Wing(2).WingSection.Chord = c_k;
I.Wing(2).WingSection.Xle = 0.2*span/2*sind(sweep_le);
I.Wing(2).WingSection.Yle = 0.2*span/2;
I.Wing(2).WingSection.Zle = 0.2*span/2*sind(5);
I.Wing(2).WingSection.FrontSparPosition = 0.15;
I.Wing(2).WingSection.RearSparPosition = 0.60;


% section 3

I.Wing(3).WingSection.Chord = c_r*taper;
I.Wing(3).WingSection.Xle = span/2*sind(sweep_le);
I.Wing(3).WingSection.Yle = span/2;
I.Wing(3).WingSection.Zle = span/2*sind(5);
I.Wing(3).WingSection.FrontSparPosition = 0.15;
I.Wing(3).WingSection.RearSparPosition = 0.60;


%% Fuel tank geometry

I.WingFuelTank.Ystart = 0;
I.WingFuelTank.Yend = 0.85;


%% Power plant and landing gear and wing structure

I.PP(1).WingEngineNumber = 1;
I.PP(1).EnginePosition = 0.2;
I.PP(1).EngineWeight = 5092;


%% Material and Structure

I.Material.Wing.UpperPanel.E = 7.0E10;
I.Material.Wing.UpperPanel.rho = 2800;
I.Material.Wing.UpperPanel.Sigma_tensile = 295.0E6;
I.Material.Wing.UpperPanel.Sigma_compressive = 295.0E6;

I.Material.Wing.LowerPanel.E = 7.0E10;
I.Material.Wing.LowerPanel.rho = 2800;
I.Material.Wing.LowerPanel.Sigma_tensile = 295.0E6;
I.Material.Wing.LowerPanel.Sigma_compressive = 295.0E6;

I.Material.Wing.FrontSpar.E = 7.0E10;
I.Material.Wing.FrontSpar.rho = 2800;
I.Material.Wing.FrontSpar.Sigma_tensile = 295.0E6;
I.Material.Wing.FrontSpar.Sigma_compressive = 295.0E6;

I.Material.Wing.RearSpar.E = 7.0E10;
I.Material.Wing.RearSpar.rho = 2800;
I.Material.Wing.RearSpar.Sigma_tensile = 295.0E6;
I.Material.Wing.RearSpar.Sigma_compressive = 295.0E6;

I.Structure.Wing.UpperPanelEfficiency = 0.96;
I.Structure.Wing.RibPitch = 0.5;

end
