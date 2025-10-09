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
title('3.1c part 1: Angular Rates of the Encoder and the Gyro vs Time (Opposite Signs)')
legend('Gyro Rate Measurement','Encoder Rate Measurement')

% Update the plot to reflect the sign change of Gyro_Output
figure()
hold on;
grid on;
plot(time_part31c,-Gyro_Output_part31c,'r');
plot(time_part31c,Input_Rate_part31c,'b');
xlabel('time (s)')
ylabel('angular rates (rad/s)')
title('3.1c part 1: Angular Rates of the Encoder and the Gyro vs Time (Uncalibrated)')
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
title('3.1c part 2: Data for Gyro Calibration')
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
title('3.1c part 3: Angular Rates of the Encoder and the Gyro vs Time (Calibrated)')
legend('Calibrated Gyro Measurement','Encoder Rate Measurement');
grid on;

%% 3.1c Part 4
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

sgtitle('3.1c part 4 section i: Time History of the Encoder Rate Measurement and the Calibrated Gyro Measurement')

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

sgtitle('3.1c part 4 section ii: Time History of the Angular Rate Measurement Error')

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

sgtitle('3.1c part 4 section iii: Time History of True Angular Position and Measured Angular Position')

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

sgtitle('3.1c part 4 section iv: Time History of the Angular Position Error')

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

sgtitle('3.1c part 4 section v: Angular Position Error as a Function of Encoder Rate Measurement')

%% Question 3.2

% Torque Reaction Wheel 5
filename_rw_torque5 = '2025_09_23_001_Torque_RW_5mNm';
data_rw_torque5 = readmatrix(filename_rw_torque5);

time_rw_torque5 = data_rw_torque5(:,1)/1000;
time_rw_torque5 = time_rw_torque5 - time_rw_torque5(2);
time_rw_torque5(1) = 0;

comanded_torque_rw5 = data_rw_torque5(:,2);
actual_torque_rw5 = data_rw_torque5(:,4) * 33.5;

angular_velocity_rw5 = data_rw_torque5(:,3) * ((2*pi)/60);

average_torque_rw5 = mean(actual_torque_rw5(102:602,1));

figure()
hold on;
grid on;
plot(time_rw_torque5, comanded_torque_rw5,'r')
plot(time_rw_torque5, actual_torque_rw5,'b');
yline(average_torque_rw5,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.2a: Actual vs Commanded Torque (Reaction Wheel at 5mNm)');

p_rw5 = polyfit(time_rw_torque5(102:602,1),angular_velocity_rw5(102:602,1),1);
acc_rw5 = polyval(p_rw5,time_rw_torque5);

figure()
hold on;
grid on;
plot(time_rw_torque5,angular_velocity_rw5)
plot(time_rw_torque5, acc_rw5)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.2a: Angular Velcoity vs Time (Reaction Wheel at 5mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Reaction Wheel 8
filename_rw_torque8 = '2025_09_23_001_Torque_RW_8mNm';
data_rw_torque8 = readmatrix(filename_rw_torque8);

time_rw_torque8 = data_rw_torque8(:,1)/1000;
time_rw_torque8 = time_rw_torque8 - time_rw_torque8(2);
time_rw_torque8(1) = 0;

comanded_torque_rw8 = data_rw_torque8(:,2);
actual_torque_rw8 = data_rw_torque8(:,4) * 33.5;

angular_velocity_rw8 = data_rw_torque8(:,3) * ((2*pi)/60);

average_torque_rw8 = mean(actual_torque_rw8(102:602,1));

figure()
hold on;
grid on;
plot(time_rw_torque8, comanded_torque_rw8,'r')
plot(time_rw_torque8, actual_torque_rw8,'b');
yline(average_torque_rw8,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.2a: Actual vs Commanded Torque (Reaction Wheel at 8mNm)');

p_rw8 = polyfit(time_rw_torque8(102:602,1),angular_velocity_rw8(102:602,1),1);
acc_rw8 = polyval(p_rw8,time_rw_torque8);

figure()
hold on;
grid on;
plot(time_rw_torque8,angular_velocity_rw8)
plot(time_rw_torque8, acc_rw8)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.2a: Angular Velcoity vs Time (Reaction Wheel at 8mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Reaction Wheel 12
filename_rw_torque12 = '2025_09_23_001_Torque_RW_12mNm';
data_rw_torque12 = readmatrix(filename_rw_torque12);

time_rw_torque12 = data_rw_torque12(:,1)/1000;
time_rw_torque12 = time_rw_torque12 - time_rw_torque12(2);
time_rw_torque12(1) = 0;

comanded_torque_rw12 = data_rw_torque12(:,2);
actual_torque_rw12 = data_rw_torque12(:,4) * 33.5;

angular_velocity_rw12 = data_rw_torque12(:,3) * ((2*pi)/60);

average_torque_rw12 = mean(actual_torque_rw12(102:602,1));

figure()
hold on;
grid on;
plot(time_rw_torque12, comanded_torque_rw12,'r')
plot(time_rw_torque12, actual_torque_rw12,'b');
yline(average_torque_rw12,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.2a: Actual vs Commanded Torque (Reaction Wheel at 12mNm)');

p_rw12 = polyfit(time_rw_torque12(102:602,1),angular_velocity_rw12(102:602,1),1);
acc_rw12 = polyval(p_rw12,time_rw_torque12);

figure()
hold on;
grid on;
plot(time_rw_torque12,angular_velocity_rw12)
plot(time_rw_torque12, acc_rw12)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.2a: Angular Velcoity vs Time (Reaction Wheel at 12mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Reaction Wheel 16
filename_rw_torque16 = '2025_09_23_001_Torque_RW_16mNm';
data_rw_torque16 = readmatrix(filename_rw_torque16);

time_rw_torque16 = data_rw_torque16(:,1)/1000;
time_rw_torque16 = time_rw_torque16 - time_rw_torque16(2);
time_rw_torque16(1) = 0;

comanded_torque_rw16 = data_rw_torque16(:,2);
actual_torque_rw16 = data_rw_torque16(:,4) * 33.5;

angular_velocity_rw16 = data_rw_torque16(:,3) * ((2*pi)/60);

average_torque_rw16 = mean(actual_torque_rw16(102:602,1));

figure()
hold on;
grid on;
plot(time_rw_torque16, comanded_torque_rw16,'r')
plot(time_rw_torque16, actual_torque_rw16,'b');
yline(average_torque_rw16,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.2a: Actual vs Commanded Torque (Reaction Wheel at 16mNm)');

p_rw16 = polyfit(time_rw_torque16(102:602,1),angular_velocity_rw16(102:602,1),1);
acc_rw16 = polyval(p_rw16,time_rw_torque16);

figure()
hold on;
grid on;
plot(time_rw_torque16,angular_velocity_rw16)
plot(time_rw_torque16, acc_rw16)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.2a: Angular Velcoity vs Time (Reaction Wheel at 16mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Reaction Wheel 20
filename_rw_torque20 = '2025_09_23_001_Torque_RW_20mNm_5sec';
data_rw_torque20 = readmatrix(filename_rw_torque20);

time_rw_torque20 = data_rw_torque20(:,1)/1000;
time_rw_torque20 = time_rw_torque20 - time_rw_torque20(2);
time_rw_torque20(1) = 0;

comanded_torque_rw20 = data_rw_torque20(:,2);
actual_torque_rw20 = data_rw_torque20(:,4) * 33.5;

angular_velocity_rw20 = data_rw_torque20(:,3) * ((2*pi)/60);

average_torque_rw20 = mean(actual_torque_rw20(102:602,1));

figure()
hold on;
grid on;
plot(time_rw_torque20, comanded_torque_rw20,'r')
plot(time_rw_torque20, actual_torque_rw20,'b');
yline(average_torque_rw12,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.2a: Actual vs Commanded Torque (Reaction Wheel at 20mNm)');

p_rw20 = polyfit(time_rw_torque20(102:602,1),angular_velocity_rw20(102:602,1),1);
acc_rw20 = polyval(p_rw20,time_rw_torque20);

figure()
hold on;
grid on;
plot(time_rw_torque20,angular_velocity_rw20)
plot(time_rw_torque20, acc_rw20)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('Angular Velcoity vs Time (Reaction Wheel at 20mNm)')
legend('3.2a: Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

%% MOI RW Calculation
moi_rw5 = average_torque_rw5/p_rw5(1);
moi_rw8 = average_torque_rw8/p_rw8(1);
moi_rw12 = average_torque_rw12/p_rw12(1);
moi_rw16 = average_torque_rw16/p_rw16(1);
moi_rw20 = average_torque_rw20/p_rw20(1);

moi_vector = [moi_rw5 moi_rw8 moi_rw12 moi_rw16 moi_rw20];
std_moi = std(moi_vector);
average_moi_rw = mean(moi_vector);

% More accurate MOI caluctions cutting off the data where the RW reached
% the max angular velocity
average_torque_rw16_accurate = mean(actual_torque_rw16(102:502,1));
p_rw16_accurate = polyfit(time_rw_torque16(102:502,1),angular_velocity_rw16(102:502,1),1);
moi_rw16_accurate = average_torque_rw16_accurate/p_rw16_accurate(1);

average_torque_rw20_accurate = mean(actual_torque_rw20(102:388,1));
p_rw20_accurate = polyfit(time_rw_torque20(102:388,1),angular_velocity_rw20(102:388,1),1);
moi_rw20_accurate = average_torque_rw20_accurate/p_rw20_accurate(1);

moi_vector_accurate = [moi_rw5 moi_rw8 moi_rw12 moi_rw16_accurate moi_rw20_accurate];
std_moi_accurate = std(moi_vector_accurate);
average_moi_rw_accurate = mean(moi_vector_accurate);

%% Question 3.3a

% Torque Base 10
filename_base_torque10 = 'Base_torque10mNm';
data_base_torque10 = readmatrix(filename_base_torque10);

time_base_torque10 = data_base_torque10(:,1)/1000;
time_base_torque10 = time_base_torque10 - time_base_torque10(2);
time_base_torque10(1) = 0;

comanded_torque_base10 = data_base_torque10(:,2);
actual_torque_base10 = data_base_torque10(:,4) * 25.5;

angular_velocity_base10 = data_base_torque10(:,3) * ((2*pi)/60);

average_torque_base10 = mean(actual_torque_base10(102:602,1));

figure()
hold on;
grid on;
plot(time_base_torque10, comanded_torque_base10,'r')
plot(time_base_torque10, actual_torque_base10,'b');
yline(average_torque_base10,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.3a: Actual vs Commanded Torque (Base at 10mNm)');

p_base10 = polyfit(time_base_torque10(102:602,1),angular_velocity_base10(102:602,1),1);
acc_base10 = polyval(p_base10,time_base_torque10);

figure()
hold on;
grid on;
plot(time_base_torque10,angular_velocity_base10)
plot(time_base_torque10, acc_base10)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.3a: Angular Velcoity vs Time (Base at 10mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')



% Torque Base 8
filename_base_torque8 = 'Base_torque8mNm';
data_base_torque8 = readmatrix(filename_base_torque8);

time_base_torque8 = data_base_torque8(:,1)/1000;
time_base_torque8 = time_base_torque8 - time_base_torque8(2);
time_base_torque8(1) = 0;

comanded_torque_base8 = data_base_torque8(:,2);
actual_torque_base8 = data_base_torque8(:,4) * 25.5;

angular_velocity_base8 = data_base_torque8(:,3) * ((2*pi)/60);

average_torque_base8 = mean(actual_torque_base8(102:602,1));

figure()
hold on;
grid on;
plot(time_base_torque8, comanded_torque_base8,'r')
plot(time_base_torque8, actual_torque_base8,'b');
yline(average_torque_base8,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.3a: Actual vs Commanded Torque (Base at 8mNm)');

p_base8 = polyfit(time_base_torque8(102:602,1),angular_velocity_base8(102:602,1),1);
acc_base8 = polyval(p_base8,time_base_torque8);

figure()
hold on;
grid on;
plot(time_base_torque8,angular_velocity_base8)
plot(time_base_torque8, acc_base8)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.3a: Angular Velcoity vs Time (Base at 8mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Base 6
filename_base_torque6 = 'Base_torque6mNm';
data_base_torque6 = readmatrix(filename_base_torque6);

time_base_torque6 = data_base_torque6(:,1)/1000;
time_base_torque6 = time_base_torque6 - time_base_torque6(2);
time_base_torque6(1) = 0;

comanded_torque_base6 = data_base_torque6(:,2);
actual_torque_base6 = data_base_torque6(:,4) * 25.5;

angular_velocity_base6 = data_base_torque6(:,3) * ((2*pi)/60);

average_torque_base6 = mean(actual_torque_base6(102:602,1));

figure()
hold on;
grid on;
plot(time_base_torque6, comanded_torque_base6,'r')
plot(time_base_torque6, actual_torque_base6,'b');
yline(average_torque_base6,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.3a: Actual vs Commanded Torque (Base at 6mNm)');

p_base6 = polyfit(time_base_torque6(102:602,1),angular_velocity_base6(102:602,1),1);
acc_base6 = polyval(p_base6,time_base_torque6);

figure()
hold on;
grid on;
plot(time_base_torque6,angular_velocity_base6)
plot(time_base_torque6, acc_base6)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.3a: Angular Velcoity vs Time (Base at 6mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Base 4
filename_base_torque4 = 'Base_torque4mNm';
data_base_torque4 = readmatrix(filename_base_torque4);

time_base_torque4 = data_base_torque4(:,1)/1000;
time_base_torque4 = time_base_torque4 - time_base_torque4(2);
time_base_torque4(1) = 0;

comanded_torque_base4 = data_base_torque4(:,2);
actual_torque_base4 = data_base_torque4(:,4) * 25.5;

angular_velocity_base4 = data_base_torque4(:,3) * ((2*pi)/60);

average_torque_base4 = mean(actual_torque_base4(102:602,1));

figure()
hold on;
grid on;
plot(time_base_torque4, comanded_torque_base4,'r')
plot(time_base_torque4, actual_torque_base4,'b');
yline(average_torque_base4,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.3a: Actual vs Commanded Torque (Base at 4mNm)');

p_base4 = polyfit(time_base_torque4(102:602,1),angular_velocity_base4(102:602,1),1);
acc_base4 = polyval(p_base4,time_base_torque4);

figure()
hold on;
grid on;
plot(time_base_torque4,angular_velocity_base4)
plot(time_base_torque4, acc_base4)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.3a: Angular Velcoity vs Time (Base at 4mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

% Torque Base 2
filename_base_torque2 = 'Base_torque2mNm';
data_base_torque2 = readmatrix(filename_base_torque2);

time_base_torque2 = data_base_torque2(:,1)/1000;
time_base_torque2 = time_base_torque2 - time_base_torque2(2);
time_base_torque2(1) = 0;

comanded_torque_base2 = data_base_torque2(:,2);
actual_torque_base2 = data_base_torque2(:,4) * 25.5;

angular_velocity_base2 = data_base_torque2(:,3) * ((2*pi)/60);

average_torque_base2 = mean(actual_torque_base2(102:602,1));

figure()
hold on;
grid on;
plot(time_base_torque2, comanded_torque_base2,'r')
plot(time_base_torque2, actual_torque_base2,'b');
yline(average_torque_base2,'g')
xlabel('Time (s)');
ylabel('Torque (mNm)');
legend('Commanded Torque', 'Actual Torque','Average Actual Torque','Location','best');
title('3.3a: Actual vs Commanded Torque (Base at 2mNm)');

p_base2 = polyfit(time_base_torque2(102:602,1),angular_velocity_base2(102:602,1),1);
acc_base2 = polyval(p_base2,time_base_torque2);

figure()
hold on;
grid on;
plot(time_base_torque2,angular_velocity_base2)
plot(time_base_torque2, acc_base2)
xlabel('Time (s)')
ylabel('Angular Velcoity (rad/s)')
title('3.3a: Angular Velcoity vs Time (Base at 2mNm)')
legend('Angular Velocity','Line of Best Fit for Angular Acceleration','Location','best')

%% MOI Base Calculation
moi_base10 = average_torque_base10/-p_base10(1);
moi_base8 = average_torque_base8/-p_base8(1);
moi_base6 = average_torque_base6/-p_base6(1);
moi_base4 = average_torque_base4/-p_base4(1);

average_moi_base = (moi_base10 + moi_base8 + moi_base6 + moi_base4)/4;

%% 3.3 after part a

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
title('3.3d: Calculated Gains (k_p = 88.88 and k_d = 32)')
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
title('3.3d: Calculated Gains (k_p = 177.76 and k_d = 32)')
legend('Measured Position', 'Reference Position', '1.5 Second','5% Settling Time','','10% Maximum Overshoot','Location','best')