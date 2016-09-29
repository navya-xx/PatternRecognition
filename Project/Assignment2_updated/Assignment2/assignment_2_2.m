%% Assignment 2.2
%
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

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms

% plot
[spectogram_fem ,f ,t ] =   GetSpeechFeatures(Yf,Ffs,winlength);
[spectogram_mal ,f ,t ] =   GetSpeechFeatures(Ym,Fms,winlength);

h1 = figure(1);

%subplot(2,1,1)
imagesc(10*log10(spectogram_fem)); % plot in dB values
colorbar;
axis xy
title('Spectrogram plot of female.wav')
annotation('doublearrow',[0.16 0.22], [0.20 0.20],'LineWidth',2);
annotation('doublearrow',[0.345 0.4],[0.24 0.24],'LineWidth',2);
annotation('textarrow',[0.376 0.376], [0.09 0.24],'String',{'Voiced "aaa" sound'});
annotation('textarrow',[0.19 0.19], [0.092 0.2],'String',{'Unvoiced "Sshh" sound'});
xlabel('time')
ylabel('frequency spectrum')
set(h1,'Position',[1,1,1200,800])

%subplot(2,1,1)
h2=figure(2);
imagesc(10*log10(spectogram_mal));
colorbar;
axis xy
title('Spectrogram plot of melody\_1.wav')
annotation('doublearrow',[0.37 0.44], [0.21 0.21],'LineWidth',2);
annotation('textarrow',[0.4 0.4],[0.074 0.21],'String',...
    {'Harmonics of "mmm" sound'}, 'HorizontalAlignment','center');
xlabel('time')
ylabel('frequency spectrum')
set(h2,'Position',[1,1,1200,800])