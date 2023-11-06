% Initialize parameters
G = 6.67430e-11;   % Gravitational constant (m^3/kg/s^2)
M = 5.972e24;      % Earth mass (kg)
r_0 = 6371000;     % Earth radius (m)
c_h = 0.8;        % Air resistance coefficient for a person
S_h = 1;           % Reference area for a person (m^2)
m = 190;           % Person's mass (kg)
rho = 0.01322;     % Air density (kg/m^3)

% Set initial conditions
r0 = 6428800; % Initial height (in meters)
v0 = 0;       % Initial velocity is zero

% Time settings
t_start = 0;          % Initial time
t_end = 120;          % End time (adjust as needed)
dt = 0.001;           % Time step

% Create arrays to store the results
t = t_start:dt:t_end;
num_steps = length(t);
r = zeros(1, num_steps);
v = zeros(1, num_steps);
a = zeros(1, num_steps);  % Array to store acceleration

% Initialize the initial conditions
r(1) = r0;
v(1) = v0;

% Solve the differential equation using Euler's method
for i = 1:num_steps-1
    r_dot = v(i);
    
    % Check if the time is before 50 seconds
    if t(i) < 50
        v_dot = -G * M / r(i)^2 + 0.5 * (c_h * rho * S_h / m) * v(i)^2;
    else
        v_dot = -G * M / r(i)^2 + (0.64175 * exp(-0.001 * (r(i) - r_0)) * c_h * S_h) / m * v(i)^2;
    end
    
    a(i) = v_dot;  % Store acceleration
    
    r(i+1) = r(i) + r_dot * dt;
    v(i+1) = v(i) + v_dot * dt;
end

% Plot descent height, velocity, and acceleration curves
figure;
subplot(3, 1, 1);
plot(t, r - r0); % Change in descent height as a function of time
xlabel('Time (seconds)');
ylabel('Change in Descent Height (meters)');
title('Change in Descent Height over Time');

subplot(3, 1, 2);
plot(t, v); % Descent velocity as a function of time
xlabel('Time (seconds)');
ylabel('Descent Velocity (m/s)');
title('Change in Descent Velocity over Time');

subplot(3, 1, 3);
plot(t, a); % Acceleration as a function of time
xlabel('Time (seconds)');
ylabel('Acceleration (m/s^2)');
title('Acceleration over Time');
