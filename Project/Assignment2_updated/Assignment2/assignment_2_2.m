%% Assignment 2.2
% The function GetSpeechFeatures can compute short-time (windowed)
% spectrograms. Use it to find spectrograms for the music sample and the
% female speech sample you downloaded, and then plot the results using the
% command imagesc. Use a window length around 30 ms.
% Make sure to put the time variable along the horizontal axis and
%use the additional outputs from GetSpeechFeatures to get correct time
%and frequency scales (and units) for your plots. Again, label your plots and
%their axes.
% You will get an easier-to-interpret picture if you take the logarithm of
%the spectrogram intensity values before plotting. This corresponds to the
%decibel scale and the logarithmic properties of human intensity perception.

addpath(strcat(pwd,'/Sounds'));
addpath(strcat(pwd,'/Songs'));
addpath(strcat(pwd,'/GetSpeechFeatures'));
% extract audio from female.wav
[Yf,Ffs] = audioread('female.wav');
% play
soundsc(Yf,Ffs);
pause(size(Yf,1)/Ffs);

% extract audio from music.wav
[Ym,Fms] = audioread('music.wav');
% play
soundsc(Ym,Fms);
pause(size(Ym,1)/Fms);

% spectogram params
X = 30;
winlength = X * 1e-3; % corresopnd to X ms

% plot
[spectogram_fem ,f1 ,t1 ] =   GetSpeechFeatures(Yf,Ffs,winlength);
[spectogram_mal ,f2 ,t2 ] =   GetSpeechFeatures(Ym,Fms,winlength);

h1 = figure(1);

%subplot(2,1,1)
imagesc(t1,  f1,  10*log10(spectogram_fem)); % plot in dB values
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
axis xy
title('Spectrogram plot of female.wav')
annotation('doublearrow',[0.16 0.22], [0.20 0.20],'LineWidth',2);
annotation('doublearrow',[0.345 0.4],[0.24 0.24],'LineWidth',2);
annotation('textarrow',[0.376 0.376], [0.09 0.24],'String',{'Voiced "aaa" sound'});
annotation('textarrow',[0.19 0.19], [0.092 0.2],'String',{'Unvoiced "Sshh" sound'});
xlabel('time [s]')
ylabel('frequency [Hz]')
set(h1,'Position',[1,1,1200,800])

%subplot(2,1,1)
h2=figure(2);
imagesc(t2, f2, 10*log10(spectogram_mal));
c = colorbar;
c.Label.String = 'Frequency spectrum |Y(f)|^2 [dB]';
axis xy
%title('Spectrogram plot of melody\_1.wav')
%annotation('doublearrow',[0.37 0.44], [0.21 0.21],'LineWidth',2);
%annotation('textarrow',[0.4 0.4],[0.074 0.21],'String',...
%    {'Harmonics of "mmm" sound'}, 'HorizontalAlignment','center');
title('Spectrogram plot of music.wav')
annotation('doublearrow', [0.227 0.285], [0.21 0.21], 'LineWidth', 2);
annotation('textarrow',[0.25 0.25],[0.074 0.21],'String',...
    {'Harmonics'}, 'HorizontalAlignment','center');
xlabel('time [s]')
ylabel('frequency [Hz]')
set(h2,'Position',[1,1,1200,800])