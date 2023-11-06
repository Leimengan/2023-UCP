% Define constants
g = 9.80665;  % Acceleration due to gravity (m/s^2)
M_a = 0.0289644;  % Mean molar mass of air (kg/mol)
R_star = 8.31432;  % Universal gas constant (J/(molK))
T0 = 288.15;  % Standard temperature at sea level (K)
rho0 = 1.225;  % Standard air density at sea level (kg/m^3)

% Define parameters
height = 0:200:80000;  % Height range from 0 to 80000 meters with 200-meter intervals

% Initialize air density vector
rho = zeros(size(height));

% Calculate air density
for i = 1:length(height)
    h = height(i);
    
    % Determine the current atmospheric layer (based on the provided table)
    if h >= 0 && h < 11000
        Tb = T0 - 0.00649 * h;
        Lb = 0.00649;
        rho(i) = rho0 * ((Tb - (h - 0) * Lb) / Tb) ^ ((g * M_a) / (R_star * Lb) - 1);
    elseif h >= 11000 && h < 20000
        Tb = 216.65;
        Lb = 0;
        rhob = 0.36391;
        rho(i) = rhob * exp(-(g * M_a * (h - 11000) / (R_star * Tb)));
    elseif h >= 25000 && h < 32000
        Tb = 216.65;
        Lb = -0.001;
        rhob = 0.08803;
        rho(i) = rhob * ((Tb - (h - 25000) * Lb) / Tb) ^ ((g * M_a) / (R_star * Lb) - 1);
    elseif h >= 32000 && h < 47000
        Tb = 228.65 + 0.0028 * (h - 32000);
        Lb = -0.0028;
        rhob = 0.01322;
        rho(i) = rhob * ((Tb - (h - 32000) * Lb) / Tb) ^ ((g * M_a) / (R_star * Lb) - 1);
    elseif h >= 47000 && h < 51000
        Tb = 270.65;
        Lb = 0;
        rhob = 0.00143;
        rho(i) = rhob * exp(-(g * M_a * (h - 47000) / (R_star * Tb)));
    elseif h >= 51000 && h < 71000
        Tb = 270.65 - 0.0028 * (h - 51000);
        Lb = 0.0028;
        rhob = 0.00086;
        rho(i) = rhob * ((Tb - (h - 51000) * Lb) / Tb) ^ ((g * M_a) / (R_star * Lb) - 1);
    else
        Tb = 214.65 - 0.002 * (h - 71000);
        Lb = 0.002;
        rhob = 0.000064;
        rho(i) = rhob * ((Tb - (h - 71000) * Lb) / Tb) ^ ((g * M_a) / (R_star * Lb) - 1);
    end
end

% Plot the air density vs. height
plot(height, rho);
title('Air Density vs. Altitude');
xlabel('Altitude (meters)');
ylabel('Air Density (kg/m^3)');
grid on;

% Check and remove NaN values from the data
valid_indices = ~isnan(rho);
height_data = height(valid_indices);
density_data = rho(valid_indices);

% Define the exponential fit function
expFitFunc = @(params, x) params(1) * exp(params(2) * x);

% Initial guess for the parameters (a and b)
initial_params = [1, -0.0001];

% Perform the exponential fit using lsqcurvefit
params = lsqcurvefit(expFitFunc, initial_params, height_data, density_data);

% Extract the fitted parameters
a = params(1);
b = params(2);

% Generate fitted data
fit_density = expFitFunc(params, height_data);

% Extract key data points
keyPointsHeight = 0:1000:5000;  % Extract key data points for visualization
keyPointsDensity = expFitFunc(params, keyPointsHeight);

% Plot the exponential fit result
figure;
plot(height_data, density_data, 'o', 'DisplayName', 'Original Data');
hold on;
plot(height_data, fit_density, 'r', 'DisplayName', 'Exponential Fit');
plot(keyPointsHeight, keyPointsDensity, 'bs', 'DisplayName', 'Key Points');
legend;

% Display the fitted equation on the plot
equation = sprintf('Fitted Equation: y = %.4f * exp(%.4f * x)', a, b);
text(10000, 0.01, equation, 'FontSize', 12);

title('Fitting an Exponential Function to Data with Key Points');
xlabel('Height (meters)');
ylabel('Air Density (kg/m^3)');
grid on;