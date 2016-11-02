function [ output_args ] = nalk_errorprobability( misMat, speakerlist)
%UNTITLED Summary of this function goes here
%   misMat: 1D Speaker, 2D Correct Word, 3D Wrong Word

nrSpeakers = size(misMat,1);
nrWords    = size(misMat,2);
errors = zeros(nrSpeakers,1);
error_words = zeros(nrWords,1);
corrects = zeros(nrSpeakers,1);
errprob = zeros(nrSpeakers,1);

for speakeridx=1:nrSpeakers
    for wordidx=1:size(misMat,2)
        corrects(speakeridx) = corrects(speakeridx) + misMat(speakeridx,wordidx,wordidx);
        errors(speakeridx) = errors(speakeridx)+ ...
            sum(misMat(speakeridx,wordidx,:)) - misMat(speakeridx,wordidx,wordidx);
        error_words(wordidx) = error_words(wordidx) + ...
            sum(misMat(speakeridx,wordidx,:)) - misMat(speakeridx,wordidx,wordidx);            
    end
    tmp = errors(speakeridx)+corrects(speakeridx);
    errprob(speakeridx) = errors(speakeridx)/tmp * 100;;
    fprintf('Misclassification for speaker %s: %d out of %d is equal to %0.2f percent\n', ...
        speakerlist(speakeridx+2).name, errors(speakeridx), ...
        tmp, errprob(speakeridx));
end
error_words = error_words./sum(error_words) * 100;
[sorted_err, sort_id] = sort(error_words);

fprintf('Total misclassifications: %d out of %d is equal to %0.2f percent\n',...
    sum(errors), sum(errors)+sum(corrects), 100*sum(errors)/(sum(errors)+sum(corrects)));
fprintf('Lowest and Highest error words: %d(error %d percent), %d(error %d percent)', ...
    sort_id(1),sorted_err(1),sort_id(end),sorted_err(end));



