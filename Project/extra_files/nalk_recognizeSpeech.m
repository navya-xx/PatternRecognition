
audiodir=0;
init    =0;
showPlots=0;
offset = 2;
filetype = '.wav';

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
    disp(strcat(int2str(ii-1), ')Female (Caroline & Madolyn)'));
    disp(strcat(int2str(ii), ')German (Caroline & Lars)'));
    disp(strcat(int2str(ii+1), ')General (All)'));
    disp(strcat(int2str(ii+2), ')General GaussMixD'));
    %disp(strcat(int2str(ii-1), ')Create new profile'));
    
    profile = str2num(input('Please enter a number: ', 's'));
    
    if profile==ii-1
        profileName = 'Female';
    elseif profile==ii
        profileName = 'German';
    elseif profile==ii+1
        profileName = 'General';
    elseif profile==ii+2
        profileName = 'GeneralGaussMix2';
    else
        profileName = profilelist(profile+2).name;
    end
    
    switch profileName
        case 'Caroline'
            load 'CarolineProfile';
        case 'Lars'
            load 'LarsProfile';
        case 'Madolyn'
            load 'MadolynProfile';
        case 'Navneet'
            load 'NavneetProfile';
        case 'Female'
            load 'FemaleProfile';
        case 'German'
            load 'GermanProfile';
        case 'General'
            load 'GeneralProfile';
        case 'GeneralGaussMix2'
            load 'GeneralProfileGaussMixD';
        %case 'New'
            % TODO
        otherwise
            disp('Error: No profile selected.');
            continue;
    end
    

    disp('Do you want to record a word (1), cross check against unused recordings (2) or start calendar app (3)?');
    action = str2num(input('Please enter a number: ', 's'));
    
    if action==1 % record word
        % create audiorecorder object
        recObj = audiorecorder(Fs, nBits, nChannels);
        record = 'y';

        while(strcmp(record,'y') || strcmp(record,'Y'))
            input('Press enter to start recording a word');
            myRecording = nalk_record(recObj, 1, 2);
    
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMS, featureVec);
            [maxP, maxPidx] = max(logP);
            disp(strcat({'The recognized word is '}, {HMMSWords{maxPidx}}));
            
            record = input('Do you want to record another word? (y/n)', 's');
        end
        
    elseif action==2 % check unused recordings
        
        % First dimension: Speaker
        % Second dimension: The correct word
        % Third dimension: The recognized word
        recognizedWords = zeros(4, nrWords,nrWords);

        disp('Start loop...');

        for idx=1+offset:nrWords+offset                   % loop through words
            word    = dirlist(idx).name;
            speakerlist = dir(strcat(audiodir,'/',word));
            nrSpeakers = size(speakerlist,1)-offset;

            for speakeridx=1+offset:nrSpeakers+offset    % loop through speakers


                speaker = speakerlist(speakeridx).name;

                for recidx=recPerWord-recForCheck+1:recPerWord             % loop through recordings
                    tmpfile = strcat(audiodir, '/', word, '/',...
                        speaker, '/', word, int2str(recidx), filetype);
                    [rec, fs]= audioread(tmpfile);
                    featureVec  = mfcc_features(rec,fs,winsize, nceps);
                    logP = logprob(HMMS, featureVec);
                    [maxP, maxPidx] = max(logP);
                    %disp(strcat('Correct word is ',word));
                    %disp(strcat('Recognized word is ',HMMSWords{maxPidx}));
                    % Add one for recognized word
                    recognizedWords(speakeridx-offset, idx-offset, maxPidx) = ...
                        recognizedWords(speakeridx-offset, idx-offset, maxPidx) +1 ; 
                end

                if showPlots
                    % plots cepstral coefficients for 4 recordings of each word 
                    % for every speaker so be careful 
                    % (produces nrSpeakers*nrWords figures)
                    plotCepsCoef(obsData, lData, word, speaker);
                end
            end

            disp(strcat({'Tests for word '}, {word}, {' finished.'}));
        end

        figure;
        for ii=1:min(4, length(speakerlist)-offset)
            subplot(2,2,ii)
            imagesc(squeeze(recognizedWords(ii,:,:)))
            colormap gray
            title(strcat('Recognized words vs correct words (',speakerlist(ii+offset).name,')'));
            xlabel('Word #');
            ylabel('Word #');
        end
    elseif action==3
        
        % create audiorecorder object
        recObj = audiorecorder(Fs, nBits, nChannels);
        
        
        % TODO calendar app
        disp('Welcome to NALK Calendar Read');
        runCalendar = 1;
        
        HMMSGreetingidx = [1, 3];
        HMMSGreeting = HMMS(HMMSGreetingidx);
        HMMSGreetingWords = {HMMSWords{HMMSGreetingidx, 1}};
        
        HMMSWeekdaysidx = [2,4,6,7,8,9,10];
        HMMSWeekdays = HMMS(HMMSWeekdaysidx);
        HMMSWeekdaysWords = {HMMSWords{HMMSWeekdaysidx, 1}};

        HMMSDecisionidx = [2,4,6,7,8,9,10];
        HMMSDecision = HMMS(HMMSDecisionidx);
        HMMSDecisionWords = {HMMSWords{HMMSDecisionsidx, 1}};
        
        
        while (runCalendar)
        
            input('To run the program, please press enter and say "hello". To terminate the program, say "bye"');
            myRecording = nalk_record(recObj, 1, 2);

            % only decide between "hello" and "bye"
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSGreeting, featureVec);
            [~, maxPidx] = max(logP);
            recWord = HMMSGreetingWords{maxPidx};
            disp(strcat({'The recognized word is '}, {recWord}));
            
            if strcmp(recWord, 'bye')
                disp('Terminate NALK Calendar App.')
                break;
            end

            % Only decide between weekdays
            disp('For which day should I view your appointments?');
            myRecording = nalk_record(recObj, 1, 2);
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSWeekdays, featureVec);
            [~, maxPidx] = max(logP);
            recWord = HMMSWeekdaysWords{maxPidx};
            disp(strcat({'The recognized word is '}, {recWord}));

            % Confirm with yes or no
            disp(strcat('View appointsments for ', {recWord}, '?'));
            myRecording = nalk_record(recObj, 1, 2);
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSDecision, featureVec);
            [maxP, maxPidx] = max(logP);
            recWord = HMMSDecisionWords{maxPidx};
            disp(strcat({'The recognized word is '}, {recWord}));
            
            if strcmp(recWord, 'no')
                continue;
            end
            
            events = nalk_getCalendarEvents(recWord);

        end
        
        
        
    end

    run = input('Do you want to run the program again? (y/n)', 's');
        
    if strcmp(run,'n') || strcmp(run, 'no') || strcmp(run, 'N')
        break; % terminate program
    end
end