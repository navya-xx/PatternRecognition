%% Project assignment 2
% author: Navneet
% 20160928

[Yf,Ffs] = audioread('female.wav');
soundsc(Yf,Ffs);
% divide steps into 1000ms chunks
%xstep = size(Y,1)/Fs * 1000;
%xax = 1:Fs/1000:size(Y,1);

xax = 0:1/Fs*1000:size(Yf,1)/Ffs*1000;
xax2 = xax(1:end-1)';
figure;
pt = plot(xax2, Yf);
title('female voice')
xlabel('milliseconds')
ylabel('amplitude value')

X = 30;
winlength = X * 1e-3; % corresopnd to X ms
ncep = 14;
[mfcc_fem, spectogram_fem ,f ,t ]=GetSpeechFeatures(Yf,Ffs,winlength, ncep);
figure;
imagesc(10*log10(spectogram_fem));
colorbar;
axis xy

%% MFCC analysis
% Female
figure;
subplot(2,1,1)
imagesc(10*log10(spectogram_fem));
subplot(2,1,2)
imagesc(10*log10(mfcc_fem));

% Male
% [Ym,Fms] = audioread('male.wav');
% soundsc(Ym,Fms);
% 
% [mfcc_mal, spectgram_mal ,f ,t ]=GetSpeechFeatures(Yf,Ffs,winlength, ncep);

