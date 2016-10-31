function [recorded_signal] = record_single_word()

% fix parameters
Fs      = 22050;
Fs_n    = 48000;
nBits   = 16;
nChannels = 1;
audio_dev_id = 2;

% create audiorecorder object
recObj = audiorecorder(Fs_n, nBits, nChannels, audio_dev_id);


% record word

    disp('Start speaking.')
    recordblocking(recObj, 2);
    disp('End of Recording.')
   
    recorded_signal = downsample(getaudiodata(recObj), Fs_n, Fs);
    
end