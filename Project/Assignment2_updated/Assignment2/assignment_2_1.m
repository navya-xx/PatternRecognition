%% Assignment 2.1
% plots
addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');
% play
soundsc(Yf,Ffs);
pause(size(Yf,1)/Ffs);

% extract audio from female.wav
[Ym,Fms] = audioread('melody_1.wav');
% play
soundsc(Ym,Fms);
pause(size(Ym,1)/Fms);


% plot with x-axis in milliseconds
xax = 0:1/Ffs*1000:size(Yf,1)/Ffs*1000;
xax = xax(2:end)'; % remove 0 time step to make length equal to signal
% plot with x-axis in milliseconds
xmax = 0:1/Fms*1000:size(Ym,1)/Fms*1000;
xmax = xmax(2:end)'; % remove 0 time step to make length equal to signal

figure;
subplot(2,1,1)
pt = plot(xax, Yf);
title('Time plot of Female voice')
xlabel('milliseconds')
ylabel('amplitude value')

subplot(2,1,2)
pt3 = plot(xmax, Ym);
title('Time plot of Music melody_1.wav')
xlabel('milliseconds')
ylabel('amplitude value')

figure;
subplot(2,2,1)
x_start = find_closest(xax,180);
x_end = find_closest(xax,200);
pt1 = plot(xax(x_start:x_end),Yf(x_start:x_end),'r');
title('(180ms, 200ms) - Female.wav : Unvoiced sound "ssshh"')

subplot(2,2,2)
x_start = find_closest(xax,720);
x_end = find_closest(xax,740);
pt1 = plot(xax(x_start:x_end),Yf(x_start:x_end),'r');
title('(720ms, 740ms) - Female.wav : Voiced sound "aaaa"')

subplot(2,2,3)
x_start = find_closest(xmax,4700);
x_end = find_closest(xmax,4720);
pt4 = plot(xmax(x_start:x_end),Ym(x_start:x_end),'r');
title('(4700ms, 4720ms) - melody\_1.wav : higher pitch "mmmm" sound')

subplot(2,2,4)
x_start = find_closest(xmax,6170);
x_end = find_closest(xmax,6190);
pt4 = plot(xmax(x_start:x_end),Ym(x_start:x_end),'r');
title('(6170ms, 6190ms) - melody\_1.wav : lower pitch "mmmm" sound')



