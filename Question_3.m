clear;
clc;
close all;

%% 3.1

%% Question 1
filename1 = '2025_09_23_001_RW_GYRO_3_1c_T1';
data = readmatrix(filename1);

time_part31c = data(:,1);
Gyro_Output_part31c = data(:,2);
Input_Rate_part31c = data(:,3);

time_part31c = time_part31c - time_part31c(2);
time_part31c(1) = 0;

% Convert input rate from rpm to rad/s
Input_Rate_part31c = Input_Rate_part31c * ((2*pi)/60);

% Plot the Gyro and the Encoder vs Time with opposite signs
figure()
grid on;
hold on;
plot(time_part31c,Gyro_Output_part31c,'r');
plot(time_part31c,Input_Rate_part31c,'b');
xlabel('time (s)')
ylabel('angular rates (rad/s)')
title('Angular Rates of the Encoder and the Gyro vs Time (Opposite Signs)')
legend('Gyro Rate Measurement','Encoder Rate Measurement')

% Update the plot to reflect the sign change of Gyro_Output
figure()
hold on;
grid on;
plot(time_part31c,-Gyro_Output_part31c,'r');
plot(time_part31c,Input_Rate_part31c,'b');
xlabel('time (s)')
ylabel('angular rates (rad/s)')
title('Angular Rates of the Encoder and the Gyro vs Time (Uncalibrated)')
legend('Gyro Rate Measurement','Encoder Rate Measurement')

%% Question 2
% Calibrate the Gyro Measurements
p_test1 = polyfit(Input_Rate_part31c, Gyro_Output_part31c,1);
Gyro_fit_test1 = polyval(p_test1, Input_Rate_part31c);

k_test1 = p_test1(1);
bias_test1 = p_test1(2);

figure()
hold on;
grid on;
scatter(Input_Rate_part31c,Gyro_Output_part31c,7,'filled')
plot(Input_Rate_part31c, Gyro_fit_test1,'r--',LineWidth=2)
yline(bias_test1,'w--')
xlabel('Encoder Rate Measurement (rad/s)')
ylabel('Gyro Rate Measurement (rad/s)')
title('Data for Gyro Calibration')
legend('Data','Adjusted Scale Factor k','Bias b')

% Calculate the calibrated Gyro Output
Calibrated_gyro_test1 = (Gyro_Output_part31c - bias_test1)/k_test1;
% Plot the calibrated Gyro Output against time
figure()
hold on;
grid on;
plot(time_part31c, Calibrated_gyro_test1, 'r');
plot(time_part31c, Input_Rate_part31c,'b')
xlabel('time (s)');
ylabel('angular rates (rad/s)');
title('Angular Rates of the Encoder and the Gyro vs Time (Calibrated)')
legend('Calibrated Gyro Measurement','Encoder Rate Measurement');
grid on;

%% Question 3
filename2 = '2025_09_23_001_RW_GYRO_3_1c_T2';
data2 = readmatrix(filename2);

filename3 = '2025_09_23_001_RW_GYRO_3_1c_T3';
data3 = readmatrix(filename3);

filename4 = '2025_09_23_001_RW_GYRO_3_1c_T4';
data4 = readmatrix(filename4);

% Process and collect the data from the 2nd file
time_part32c = data2(:,1);
time_part32c = time_part32c - time_part32c(2);
time_part32c(1) = 0;

Gyro_Output_part32c = data2(:,2);
Input_Rate_part32c = data2(:,3) * ((2*pi)/60);

p_test2 = polyfit(Input_Rate_part32c, Gyro_Output_part32c,1);
k_test2 = p_test2(1);
bias_test2 = p_test2(2);

% Process and collect the data from the 3rd file
time_part33c = data3(:,1);
time_part33c = time_part33c - time_part33c(2);
time_part33c(1) = 0;

Gyro_Output_part33c = data3(:,2);
Input_Rate_part33c = data3(:,3) * ((2*pi)/60);

p_test3 = polyfit(Input_Rate_part33c, Gyro_Output_part33c,1);
k_test3 = p_test3(1);
bias_test3 = p_test3(2);

% Process and collect the data from the 4th file
time_part34c = data4(:,1);
time_part34c = time_part34c - time_part34c(2);
time_part34c(1) = 0;

Gyro_Output_part34c = data4(:,2);
Input_Rate_part34c = data4(:,3) * ((2*pi)/60);

p_test4 = polyfit(Input_Rate_part34c, Gyro_Output_part34c,1);
k_test4 = p_test4(1);
bias_test4 = p_test4(2);

k = [k_test1, k_test2, k_test3, k_test4];
bias = [bias_test1, bias_test2, bias_test3, bias_test4];

mean_k = mean(k);
mean_bias = mean(bias);

std_k = std(k);
std_bias = std(bias);

%% Question 4

% Data set 2
Calibrated_gyro_test2 = (Gyro_Output_part32c - bias_test2)/k_test2;
% Data set 3
Calibrated_gyro_test3 = (Gyro_Output_part33c - bias_test3)/k_test3;


% Part 1

% Data set 2
figure()
subplot(2,1,1)
hold on;
plot(time_part32c,Calibrated_gyro_test2,'r')
plot(time_part32c, Input_Rate_part32c,'b')
xlabel('time (s)');
ylabel('angular rates (rad/s)');
title('Data Set 2');
legend('Calibrated Gyro Measurement','Encoder Rate Measurement');
grid on;

% Data set 3
subplot(2,1,2)
hold on;
plot(time_part33c,Calibrated_gyro_test3,'r')
plot(time_part33c, Input_Rate_part33c,'b')
xlabel('time (s)');
ylabel('angular rates (rad/s)');
title('Data Set 3');
legend('Calibrated Gyro Measurement','Encoder Rate Measurement');
grid on;

sgtitle('Time History of the Encoder Rate Measurement and the Calibrated Gyro Measurement')

% Part 2

% Data set 2
figure()
subplot(2,1,1)
grid on;
plot(time_part32c, Calibrated_gyro_test2-Input_Rate_part32c)
xlabel('time (s)')
ylabel('angular rate difference (rad/s)')
title('Data Set 2')

% Data set 3
subplot(2,1,2)
grid on;
plot(time_part33c, Calibrated_gyro_test3-Input_Rate_part33c)
xlabel('time (s)')
ylabel('angular rate difference (rad/s)')
title('Data Set 3')

sgtitle('Time History of the Angular Rate Measurement Error')

% Angular Position Calculations

% Data set 2
Gyro_position_part32c = cumtrapz(time_part32c, Calibrated_gyro_test2);
Input_position_part32c = cumtrapz(time_part32c, Input_Rate_part32c);

% Data set 3
Gyro_position_part33c = cumtrapz(time_part33c, Calibrated_gyro_test3);
Input_position_part33c = cumtrapz(time_part33c, Input_Rate_part33c);

% Part 3

% Data set 2
figure()
subplot(2,1,1)
grid on;
hold on;
plot(time_part32c,Gyro_position_part32c,'r')
plot(time_part32c, Input_position_part32c,'b')
xlabel('time (s)');
ylabel('angular position (rad)');
title('Data Set 2');
legend('Measured Angular Position (Gyro)','True Angular Position (Encoder)');

subplot(2,1,2)
grid on;
hold on;
plot(time_part33c,Gyro_position_part33c,'r')
plot(time_part33c, Input_position_part33c,'b')
xlabel('time (s)');
ylabel('angular position (rad)');
title('Data Set 3');
legend('Measured Angular Position (Gyro)','True Angular Position (Encoder)');

sgtitle('Time History of True Angular Position and Measured Angular Position')

% Part 4
figure()
subplot(2,1,1)
grid on;
plot(time_part32c,Gyro_position_part32c-Input_position_part32c)
xlabel('time (s)')
ylabel('angular position difference (rad)')
title('Data Set 2')

subplot(2,1,2)
grid on;
plot(time_part33c,Gyro_position_part33c-Input_position_part33c)
xlabel('time (s)')
ylabel('angular position difference (rad)')
title('Data Set 3')

sgtitle('Time History of the Angular Position Error')

% Part 5
figure()
subplot(2,1,1)
grid on;
plot(Input_Rate_part32c, Gyro_position_part32c-Input_position_part32c)
xlabel('encoder rate (rad/s)')
ylabel('angular position error (rad)')
title('Data Set 2')

subplot(2,1,2)
grid on;
plot(Input_Rate_part33c, Gyro_position_part33c-Input_position_part33c)
xlabel('encoder rate (rad/s)')
ylabel('angular position error (rad)')
title('Data Set 3')

sgtitle('Angular Position Error as a Function of Encoder Rate Measurement')

%% 3.3
%% Calculated Values
filename_calculated = 'Final_kp_kd_values';
data_calculated = load(filename_calculated);

time_calculated = data_calculated(:,1)/1000;
time_calculated = time_calculated - time_calculated(2);
time_calculated(1) = 0;

measured_position_calculated = data_calculated(:,3);
reference_position_calculated = data_calculated(:,2);

figure()
hold on;
grid on;
xlabel('time (s)')
ylabel('position (rad)')
plot(time_calculated, measured_position_calculated,'b');
plot(time_calculated, reference_position_calculated,'r');
xline(1.5+0.87,'w')
yline(0.5+0.025,'g--')
yline(0.5-0.025,'g--')
yline(0.5+0.05,'y')
ylim([0 0.6])
title('Calculated Gains (k_p = 88.88 and k_d = 32)')
legend('Measured Position', 'Reference Position', '1.5 Second','5% Settling Time','','10% Maximum Overshoot','Location','best')

%% Experimental Values

filename_experimental = 'TestFinal_kd_kp_values8';
data_experimental = load(filename_experimental);

time_experimental = data_experimental(:,1)/1000;
time_experimental = time_experimental - time_experimental(2);
time_experimental(1) = 0;

measured_position_experimental = data_experimental(:,3);
reference_position_experimental = data_experimental(:,2);

figure()
hold on;
grid on;
xlabel('time (s)')
ylabel('position (rad)')
plot(time_experimental, measured_position_experimental,'b');
plot(time_experimental, reference_position_experimental,'r');
xline(1.5+1.045,'w')
yline(0.5+0.025,'g--')
yline(0.5-0.025,'g--')
yline(0.5+0.05,'y')
ylim([0 0.6])
title('Calculated Gains (k_p = 177.76 and k_d = 32)')
legend('Measured Position', 'Reference Position', '1.5 Second','5% Settling Time','','10% Maximum Overshoot','Location','best')