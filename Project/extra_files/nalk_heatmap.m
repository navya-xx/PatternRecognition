function [  ] = nalk_heatmap( word, speaker, audiodir, ...
    filetype, winsize, nceps )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


tmpfile = strcat(audiodir, '/', word, '/',...
        speaker, '/', word, int2str(2), filetype);
[rec, fs]= audioread(tmpfile);
%rec     = cutSilence(rec);
featureVec  = mfcc_features(rec,fs,winsize, nceps);
imagesc(featureVec(1:13,:));
axis xy
colormap jet;
c = colorbar;
c.Label.String = 'Coefficient amplitude';
title(sprintf('Cepstrogram plot of "%s" by %s', word, speaker));
xlabel('time [frame]')
ylabel('frequency cepstrum [coefficient #]')
        

end

