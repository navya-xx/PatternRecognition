
audiodir=0;
init    =0;

disp('Welcome to NALK Speech Recognizer!');
disp(' ');

while(1)
    
    if ~audiodir
        input('Press enter to select folder with audio training data');
        audiodir = uigetdir(pwd, 'Select audio recording folder');
    end
    
    disp('');
    if ~init
        addpath(audiodir);
        dirlist = dir(audiodir);   % list recorded words
        disp('The following words were found in the audio recordings:');
        nrWords = length(dirlist)-2;
        for ii=3:length(dirlist)
            disp(strcat(int2str(ii-2),') ', dirlist(ii).name));
        end
    end
    
    disp(' ');
    disp('Do you want to use one of the existing profiles for speech recognition or create a new one?');
    profilelist = dir(strcat(audiodir, '/', dirlist(3).name));
    
    for ii=3:length(profilelist)
       disp(strcat(int2str(ii-2), ') ', profilelist(ii).name));
    end
    disp(strcat(int2str(ii-1), ')Create new profile'));
    
    profile = str2num(input('Please enter a number: ', 's'));
    
    if profile==ii-1
        profileName = 'New';
    else
        profileName = profilelist(profile+2).name;
    end
    
    switch profileName
        case 'Caroline'
            % TODO
        case 'Lars'
            load 'LarsProfile';
        case 'Madolyn'
            % TODO
        case 'Navneet'
            load 'NavneetProfile';
        case 'New'
            % TODO
        otherwise
            disp('Error: No profile selected.');
    end
    

    disp('Do you want to record a word (1) or cross check against unused recordings (2)?');
    action = str2num(input('Please enter a number: ', 's'));
    
    if action==1
        % create audiorecorder object
        recObj = audiorecorder(Fs, nBits, nChannels);
        record = 'y';

        while(strcmp(record,'y') || strcmp(record,'Y'))
            input('Press enter to start recording a word');
            pause(1)
            disp('Started recording...');
            recordblocking(recObj, 2);
            disp('Stopped recording...');
            % Store data in double-precision array.
            myRecording = getaudiodata(recObj);
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMS, featureVec);
            [maxP, maxPidx] = max(logP);
            disp(strcat('The recognized word is ', HMMSWords{maxPidx}));
            
            record = input('Do you want to record another word? (y/n)', 's');
        end
        
    elseif action==2
        % TODO add action
    end

    run = input('Do you want to run the program again? (y/n)', 's');
        
    if strcmp(run,'n') || strcmp(run, 'no') || strcmp(run, 'N')
        break; % terminate program
    end
end