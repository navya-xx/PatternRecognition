function [  ] = plotCepsCoef( obsData, lData, word, speaker )
%Creates a figure with four heat map for cepstral coefficients
%   Detailed explanation goes here

figure;

for ii=1:4
    subplot(2,2,ii)
    startidx = 1;
    if ii>1
        startidx = lData(ii-1)+1;
    end
    imagesc(obsData(1:13,startidx:startidx+lData(ii)));
    axis xy
    colormap jet;
    c = colorbar;
    c.Label.String = 'Coefficient amplitude';
    title(strcat('Cepstrogram plot of ', word, ' by ', speaker));
    xlabel('time [frame]')
    ylabel('frequency cepstrum [coefficient #]')
end

end

