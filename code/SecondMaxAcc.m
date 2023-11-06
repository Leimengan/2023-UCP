% Initialize parameters
G = 6.67430e-11;   % Gravitational constant (m^3/kg/s^2)
M = 5.972e24;      % Earth mass (kg)
r_0 = 6371000;     % Earth radius (m)
c_h = 0.8;        % Air resistance coefficient for a person
S_h = 1;           % Reference area for a person (m^2)
m = 190;           % Person's mass (kg)

% Time settings
t_start = 0;          % Initial time
t_end = 300;          % End time (adjust as needed)
dt = 0.001;           % Time step

% Define the range of initial heights
initial_heights = 6381000:100:6451000; % Adjust the step size as needed

% Initialize arrays to store results
max_accelerations = zeros(size(initial_heights));

% Loop through different initial heights
for i = 1:length(initial_heights)
    r0 = initial_heights(i); % Set the initial height
    
    % Initialize arrays to store velocity and acceleration
    velocities = zeros(1, ceil((t_end - t_start) / dt));
    accelerations = zeros(1, ceil((t_end - t_start) / dt));
    
    % Initial conditions
    r = r0;
    v = 0;
    
    % Time loop
    t = t_start;
    j = 1;
    while t < t_end
        % Calculate gravitational force
        F_gravity = -G * M * m / r^2;
        
        % Calculate air resistance force
        F_air_resistance = 0.64175 * exp(-0.001 * (r - r_0)) * c_h * S_h * v^2;
        
        % Calculate acceleration
        acceleration = (F_gravity + F_air_resistance) / m;
        
        % Update velocity and position using the Verlet method
        v = v + acceleration * dt;
        r = r + v * dt;
        
        % Store velocity and acceleration at this time step
        velocities(j) = v;
        accelerations(j) = acceleration;
        
        % Update time
        t = t + dt;
        j = j + 1;
    end
    
    % Find and store the maximum acceleration
    max_accelerations(i) = max(abs(accelerations));
end

% Plot the relationship between initial height and maximum acceleration
figure;
plot(initial_heights, max_accelerations, 'o-');
xlabel('Initial Height (m)');
ylabel('Maximum Acceleration (m/s^2)');
title('Relationship between Initial Height and Maximum Acceleration');
grid on;

