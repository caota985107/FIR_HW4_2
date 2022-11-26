clear all; clc; close all;
%% 
Fs = 8000;
t = linspace(0,0.5,Fs); %0.5 seconds
f1 = 10;  %100Hz signal
f2 = 5000; %5000Hz signal
x1 = cos(2*pi*f1*t);
x2 = cos(2*pi*f2*t);
x_combined = x1 + x2;
%% plot input data
figure;
subplot(3,1,1)
plot(t,x1); title("$cos(2\pi *10*t)$","Interpreter","latex");
subplot(3,1,2)
plot(t,x2); title("$cos(2\pi *5000*t)$","Interpreter","latex");
subplot(3,1,3)
plot(t,x_combined); title("mixed signal");



%%  FIR filter : kaiser window method
lpFilt = designfilt('lowpassfir','PassbandFrequency',1500,...
         'StopbandFrequency',2000,'PassbandRipple',0.01, ...
         'StopbandAttenuation',40,'DesignMethod','kaiserwin','SampleRate',8000);
filter_vis=fvtool(lpFilt);
filter_vis.DesignMask='on';

%
b = lpFilt.Coefficients;
N_TAPS = length(b)-1;

%% Filtering & Plot

figure;  grid on;


%input
    [ho,wo] = freqz(x_combined);
    ho_db = 20*log10(abs(ho)); %我那裏寫錯了，前面db要乘上20
    wo2f = (wo/pi*Fs/2);
    plot(wo2f,ho_db,'r');
    title('Frequency response, original data');
    xlabel('Frequency');
    ylabel('Magnitude');
    hold on;
%output after filter 
    y = conv(b,x_combined);
    [h,w] = freqz(y);
    h_db = 20*log10(abs(h)); %我那裏寫錯了，前面db要乘上20
    w2f = (w/pi*Fs/2);
    plot(w2f, h_db,'b');
    title('Frequency response, filtered data');
    xlabel('Frequency');
    ylabel('Magnitude');

    legend('original data','filtered data');

%% Plot at Time domain

figure;
plot(t,x_combined);
hold on;
plot(t,y(N_TAPS+1:end),'LineWidth',1.3); %拿掉前面長度，

% xlim([t(1),t(100)]);




