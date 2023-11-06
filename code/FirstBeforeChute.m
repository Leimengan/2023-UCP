% Initialize parameters
G = 6.67430e-11;   % Gravitational constant (m^3/kg/s^2)
M = 5.972e24;      % Earth mass (kg)
rho = 1.225;       % Air density (kg/m^3)
c_h = 0.47;        % Air resistance coefficient for a person
S_h = 1;           % Reference area for a person (m^2)
m = 190;           % Person's mass (kg)

% Set initial conditions
r0 = 6421000; % Initial height (in meters)
v0 = 0;    % Initial velocity is zero

% Solve the differential equation
tspan = [0, 500]; % Time interval
t = linspace(tspan(1), tspan(2), 10000);
f = @(t, y) [y(2); -G*M / y(1)^2 + 0.5 * c_h * rho * S_h / m * y(2)^2];
[t, y] = ode45(f, t, [r0, v0]);

descent_height_change = -y(1, 1) + y(:, 1);

% Plot descent height and velocity curves
figure;
subplot(2, 1, 1);
plot(t, descent_height_change); % Change in descent height as a function of time
xlabel('Time (seconds)');
ylabel('Change in Descent Height (meters)');
title('Change in Descent Height over Time');

subplot(2, 1, 2);
plot(t, y(:, 2)); % Descent velocity as a function of time
xlabel('Time (seconds)');
ylabel('Descent Velocity (m/s)');
title('Change in Descent Velocity over Time');
