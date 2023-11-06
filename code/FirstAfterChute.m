% Initialize parameters
G = 6.67430e-11;   % Gravitational constant (m^3/kg/s^2)
M = 5.972e24;      % Earth mass (kg)
rho = 1.225;       % Air density (kg/m^3)
c_p = 0.8;         % Air resistance coefficient for a person
S_p = 70;          % Reference area for a person (m^2)
m = 190;           % Person's mass (kg)

% Set initial conditions
r0 = 6372000; % Initial height (in meters)
v0 = -80;    

% Solve the differential equation
tspan = [0, 50]; % Time interval
t = linspace(tspan(1), tspan(2), 10000);
f = @(t, y) [y(2); -G*M / y(1)^2 + 0.5 * c_p * rho * S_p / m * y(2)^2];
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

% Calculate acceleration
acceleration = diff(y(:, 2))./diff(t); % Calculate acceleration from velocity changes

% Adjust the time interval to match the acceleration data
t_acceleration = t(1:end-1);

% Plot the relationship between acceleration and time
figure;
plot(t_acceleration, acceleration);
xlabel('Time (seconds)');
ylabel('Acceleration (m/s^2)');
title('Change in Acceleration over Time');


