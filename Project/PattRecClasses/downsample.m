function signal_new = downsample(signal, Fs1, Fs2)
% makeshift function to downsample from Fs1 to Fs2    

    [P,Q] = rat(Fs2/Fs1);
    signal_new = resample(signal, P,Q);
end