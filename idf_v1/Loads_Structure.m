function Wwing=Loads_Structure(I, M_cr, h_cr)

filename='test';


%% Geometry and load calculations

DisplayOption = 0;

%I = Initiator(c_r, sweep_le, taper, span, k_u, k_l, W_str, W_fuel);

visc = 0; 
sizing = 1; %
Res_sizing = Q3D_Start(visc, sizing, I, M_cr, h_cr); % non viscous analysis (only ccl and cm_c4 are needed)


AS.Y = linspace(0,1,20);
q = 0.5*Utils.density(h_cr)*M_cr*Utils.sound_speed(h_cr)^2;
MAC = 2/3*I.Wing(1).WingSection.Chord*(1+I.Wing(1).Taper+I.Wing(1).Taper^2)/(1+I.Wing(1).Taper);
AS.L = interp1(Res_sizing.Wing.Yst, Res_sizing.Wing.ccl.*q, AS.Y*I.Wing(1).Span/2, 'spline');
AS.T = interp1(Res_sizing.Wing.Yst, Res_sizing.Wing.cm_c4.*Res_sizing.Wing.chord*q*MAC, AS.Y*I.Wing(1).Span/2, 'spline');


%% Creating airfoil coordinate file

delete('airfoil.dat')
fid = fopen('airfoil.dat', 'wt');
X0 = linspace(0,1,99);
X1 = flip(X0);
[Yust,Ylst] = Utils.D_airfoil(I.Wing(1).CST_Upper,I.Wing(1).CST_Lower,X0);

for i=1:length(X0)
    fprintf(fid,'%g %g\n', X1(i), Yust(i));
end
for i=1:length(X0)
    fprintf(fid,'%g %g\n', X0(i), Ylst(i));
end

fclose(fid);
%% Creating init file

fid = fopen('test.init', 'wt');
fprintf(fid, '%g %g \n',I.Weight.MTOW,I.Weight.ZFW);
fprintf(fid, '%g \n',I.n_max);
fprintf(fid, '%g %g %g %g \n',I.Wing(1).Area,I.Wing(1).Span,I.Wing(1).SectionNumber,I.Wing(1).AirfoilNumber);

for i=1:length(I.Wing(1).AirfoilPosition)
    fprintf(fid,'%g %s\n', I.Wing(1).AirfoilPosition(i), I.Wing(1).AirfoilName);
end

for i=1:I.Wing(1).SectionNumber
    fprintf(fid, '%g %g %g %g %g %g \n', I.Wing(i).WingSection.Chord, I.Wing(i).WingSection.Xle, I.Wing(i).WingSection.Yle, I.Wing(i).WingSection.Zle, I.Wing(i).WingSection.FrontSparPosition, I.Wing(i).WingSection.RearSparPosition);
end

fprintf(fid, '%g %g \n',I.WingFuelTank.Ystart,I.WingFuelTank.Yend);

fprintf(fid, '%g \n', I.PP(1).WingEngineNumber);
fprintf(fid, '%g  %g \n', I.PP(1).EnginePosition,I.PP(1).EngineWeight);

fprintf(fid, '%g %g %g %g \n',I.Material.Wing.UpperPanel.E,I.Material.Wing.UpperPanel.rho,I.Material.Wing.UpperPanel.Sigma_tensile,I.Material.Wing.UpperPanel.Sigma_compressive);
fprintf(fid, '%g %g %g %g \n',I.Material.Wing.LowerPanel.E,I.Material.Wing.LowerPanel.rho,I.Material.Wing.LowerPanel.Sigma_tensile,I.Material.Wing.LowerPanel.Sigma_compressive);
fprintf(fid, '%g %g %g %g \n',I.Material.Wing.FrontSpar.E,I.Material.Wing.FrontSpar.rho,I.Material.Wing.FrontSpar.Sigma_tensile,I.Material.Wing.FrontSpar.Sigma_compressive);
fprintf(fid, '%g %g %g %g \n',I.Material.Wing.RearSpar.E,I.Material.Wing.RearSpar.rho,I.Material.Wing.RearSpar.Sigma_tensile,I.Material.Wing.RearSpar.Sigma_compressive);

fprintf(fid,'%g %g \n',I.Structure.Wing.UpperPanelEfficiency,I.Structure.Wing.RibPitch);
fprintf(fid,'%g\n', DisplayOption);
fclose(fid);

%% Creating load file

fid = fopen('test.load', 'wt');

for i=1:length(AS.Y)
    fprintf(fid,'%g %g %g\n', AS.Y(i),AS.L(i),AS.T(i));
end

fclose(fid);

%% Running EMWET

EMWET test

%% Reading output

fid = fopen('test.weight','r');
OUT = textscan(fid,'%s');
fclose(fid);

out = OUT{1};
Wwing = str2double(out(4));

end
