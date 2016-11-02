% NALK Speech Recognizer
% Script that allows to recognize one word out of a particular set of 
% words, to evaluate its performance with data that wasn't used during 
% training or to run a dummy calendar app
% 
% KTH Royal Institute of Technology, Stockholm, Sweden
% Fall Term 2016, Pattern Recognition course
% Authors: Navneet Agrawal and Lars Kuger

% Quick facts:
% nStates = 2*wordlength + 2
% nceps = 10
% nTrainingRec = 9
% nCheckRec = 5
% Single Person: GaussD
% More persons: GaussMixD 2 and 3


audiodir=0;
init    =0;
showPlots=0;
offset = 2;
filetype = '.wav';
speakingCalendar = 1;

fprintf('----------------------------------\n');
fprintf('Welcome to NALK Speech Recognizer!\n');
fprintf('----------------------------------\n');

while(1)
    
    %% Initialize
    % Make user select folder with audio data
    if ~audiodir
        input('Press enter to select folder with audio data');
        audiodir = uigetdir(pwd, 'Select audio recording folder');
    end
    
    % List the words that were found in the directory
    if ~init
        addpath(audiodir);
        dirlist = dir(audiodir); 
        fprintf('\nThe following words were found in the audio recordings:\n');
        nrWords = length(dirlist)-2;
        for ii=3:length(dirlist)
            fprintf('\t%d) %s\n', ii-2, dirlist(ii).name);
        end
    end
    
    %% Make user choose a profile
    % Each profile is trained by different training data
    % The one which works best is the General GaussMixD
    
    fprintf('\nDo you want to use one of the existing profiles for speech recognition or create a new one?\n');
    profilelist = dir(strcat(audiodir, '/', dirlist(3).name));
    for ii=3:length(profilelist)
       fprintf('\t%d) %s\n', ii-2, profilelist(ii).name);
    end
    fprintf('\t%d) %s\n', ii-1, 'General (All)');
    fprintf('\t%d) %s\n', ii, 'General GaussMixD(2)');
    fprintf('\t%d) %s\n', ii+1, 'General GaussMixD(3)');
    
    profile = str2num(input('Please enter a number: ', 's'));
    
    if profile==ii-1
        profileName = 'General';
    elseif profile==ii
        profileName = 'GeneralGaussMix2';
    elseif profile==ii+1
        profileName = 'GeneralGaussMix3';
    else
        profileName = profilelist(profile+2).name;
    end
    
    % load the corresponding trained HMMs for the words
    % profiles used 9 recordings for training
    switch profileName
        case 'Caroline'
            load 'CarolineProfile';
        case 'Lars'
            load 'LarsProfile';
        case 'Madolyn'
            load 'MadolynProfile';
        case 'Navneet'
            load 'NavneetProfile';
        case 'General'
            load 'GeneralProfile';
        case 'GeneralGaussMix2'
            load 'GeneralProfileGaussMixD';
        case 'GeneralGaussMix3'
            load 'GeneralProfileGaussMixD3';
        %case 'New'
            % TODO
        otherwise
            disp('Error: No profile selected.');
            continue;
    end
    fprintf('Profile %s loaded\n', profileName);
    
    % let user choose which application she wants to run
    fprintf('\nWhat would you like to do?\n')
    fprintf('\t1) record a word\n');
    fprintf('\t2) cross check against unused recordings\n');
    fprintf('\t3) start calendar app\n');
    fprintf('\t4) plot HMM/rand generated data\n');
    action = str2num(input('Please enter a number: ', 's'));
    
    
    if action==1 
        %% record a word and recognize it
        
        % create audiorecorder object
        recObj = audiorecorder(Fs, nBits, nChannels);
        record = 'y';

        while(strcmp(record,'y') || strcmp(record,'Y'))
            input('\nPress enter to start recording a word and wait until recording starts.');
            myRecording = nalk_record(recObj, 1, 2);
    
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMS, featureVec);
            [maxP, maxPidx] = max(logP);
            fprintf('The recognized word is "%s".\n', HMMSWords{maxPidx});
            %disp(strcat({'The recognized word is '}, {HMMSWords{maxPidx}}));
            
            record = input('Do you want to record another word? (y/n)', 's');
        end
        
    elseif action==2 
        %% Evaluate the performance by checking unused audio data
        
        % First dimension: Speaker
        % Second dimension: The correct word
        % Third dimension: The recognized word
        recognizedWords = zeros(4, nrWords,nrWords);

        fprintf('Start loop...\n');

        for idx=1+offset:nrWords+offset    % loop through words
            word    = dirlist(idx).name;
            speakerlist = dir(strcat(audiodir,'/',word));
            nrSpeakers = size(speakerlist,1)-offset;

            for speakeridx=1+offset:nrSpeakers+offset % loop through speakers

                speaker = speakerlist(speakeridx).name;

                for recidx=recPerWord-recForCheck+1:recPerWord % loop through recordings
                    
                    % read file, extract features, calculate probabilities
                    % and pick most likely word
                    tmpfile = strcat(audiodir, '/', word, '/',...
                        speaker, '/', word, int2str(recidx), filetype);
                    [rec, fs]= audioread(tmpfile);
                    featureVec  = mfcc_features(rec,fs,winsize, nceps);
                    logP = logprob(HMMS, featureVec);
                    [maxP, maxPidx] = max(logP);

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

            fprintf('Tests for word "%s" completed.\n', word);
        end

        % Make plots for performance 
        figure;
        for ii=1:min(4, length(speakerlist)-offset)
            subplot(2,2,ii)
            imagesc(squeeze(recognizedWords(ii,:,:)))
            colormap gray
            title(sprintf('Recognition performance (%s)',speakerlist(ii+offset).name));
            xlabel('Recognized Word #');
            ylabel('Correct Word #');
        end
        
        % output error probability
        nalk_errorprobability(recognizedWords, speakerlist);
        
    elseif action==3
        %% Run dummy calendar app
        
        % create audiorecorder object
        recObj = audiorecorder(Fs, nBits, nChannels);
        
        load calendarPhrases
        
        % TODO calendar app
        fprintf('\nWelcome to NALK Calendar Read\n\n');
        runCalendar = 1;
        
        if speakingCalendar
            wait = 0.01;
        else
            wait = 2;
        end
        
        HMMSGreetingidx = [1, 3];
        HMMSGreeting = HMMS(HMMSGreetingidx);
        HMMSGreetingWords = {HMMSWords{HMMSGreetingidx, 1}};
        
        HMMSWeekdaysidx = [2,4,6,7,8,9,10];
        HMMSWeekdays = HMMS(HMMSWeekdaysidx);
        HMMSWeekdaysWords = {HMMSWords{HMMSWeekdaysidx, 1}};

        HMMSDecisionidx = [5,11];
        HMMSDecision = HMMS(HMMSDecisionidx);
        HMMSDecisionWords = {HMMSWords{HMMSDecisionidx, 1}};
        
        
        while (runCalendar)
        
            if ~speakingCalendar
                input('To run the program, please press enter and say "hello". To terminate the program, say "bye"');
            else
                soundsc(hellobye, Fs);
                pause(length(hellobye)/Fs);
                soundsc(beep, Fs);
                pause(length(beep)/Fs);
            end
            myRecording = nalk_record(recObj, wait, 2);

            % only decide between "hello" and "bye"
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSGreeting, featureVec);
            [~, maxPidx] = max(logP);
            recWord = HMMSGreetingWords{maxPidx};
            fprintf('The recognized word is "%s".\n', recWord);
            
            if strcmp(recWord, 'bye')
                fprintf('Terminate NALK Calendar App.\n')
                break;
            end

            % Only decide between weekdays
            if ~speakingCalendar
                fprintf('\nFor which day would you like to view the schedule?\n');
            else
                soundsc(forwhich, Fs);
                pause(length(forwhich)/Fs);
                soundsc(beep, Fs);
                pause(length(beep)/Fs);
            end
            myRecording = nalk_record(recObj, wait, 2);
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSWeekdays, featureVec);
            [~, maxPidx] = max(logP);
            weekday = HMMSWeekdaysWords{maxPidx};
            fprintf('The recognized word is "%s".\n', weekday);

            % Confirm with yes or no
            if ~speakingCalendar
                fprintf('\nDo you want to view the schedule for %s?\n', weekday);
            else
                switch weekday
                    case 'monday'
                        tmp = [viewfor; monday];
                    case 'tuesday'
                        tmp = [viewfor; tuesday];
                    case 'wednesday'
                        tmp = [viewfor; wednesday];
                    case 'thursday'
                        tmp = [viewfor; thursday];
                    case 'friday'
                        tmp = [viewfor; friday];
                    case 'saturday'
                        tmp = [viewfor; saturday];
                    case 'sunday'
                        tmp = [viewfor; sunday];
                end
                soundsc(tmp, Fs);
                pause(length(tmp)/Fs);
                soundsc(beep, Fs);
                pause(length(beep)/Fs);
            end
            
            myRecording = nalk_record(recObj, wait, 2);
            featureVec = mfcc_features(myRecording,fs,winsize, nceps);
            logP = logprob(HMMSDecision, featureVec);
            [maxP, maxPidx] = max(logP);
            recWord = HMMSDecisionWords{maxPidx};
            fprintf('The recognized word is "%s".\n', recWord);
            
            if strcmp(recWord, 'no')
                continue;
            end
            
            events = nalk_getCalendarEvents(weekday);
            pause(5);
            
        end
        
    elseif action==4
        [randX, ~] = rand(HMMS(1),2*22050*0.02);
        [randX2, ~] = rand(HMMS(1),2*22050*0.02);
        word = 'bye';

        figure;
        
        subplot(2,2,1);
        imagesc(randX(1:13,:));
        axis xy
        colormap jet;
        c = colorbar;
        c.Label.String = 'Coefficient amplitude';
        title(sprintf('Cepstrogram plot of "%s" by %s', word, 'HMM/rand'));
        xlabel('time [frame]')
        ylabel('frequency cepstrum [coefficient #]')
        
        subplot(2,2,2);
        imagesc(randX2(1:13,:));
        axis xy
        colormap jet;
        c = colorbar;
        c.Label.String = 'Coefficient amplitude';
        title(sprintf('Cepstrogram plot of "%s" by %s', word, 'HMM/rand 2'));
        xlabel('time [frame]')
        ylabel('frequency cepstrum [coefficient #]')
        
        for ii=1:2
            subplot(2,2,ii+2);
            nalk_heatmap(word,speakerlist(ii+4).name,audiodir,filetype,winsize,nceps);
        end
        
        
    end

    fprintf('\n--------------------------------------------\n');
    run = input('Do you want to run the program again? (y/n)', 's');
        
    if strcmp(run,'n') || strcmp(run, 'no') || strcmp(run, 'N')
        fprintf('Exit program.\n');
        break; % terminate program
    end
end