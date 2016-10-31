function [res] = load_file(id)
    person = {'navneet','lars'};
    personFolder = {'Navneet','Lars'};
    addpath(strcat(pwd,'/',personFolder{id}));
    addpath(strcat(pwd,'/../PattRecClasses'));
    addpath(strcat(pwd,'/GetSpeechFeatures'));
    load(strcat('TrainedHMM-2Wordlength2States-recTr12-002sec_',person{id},'.mat'));
    res = 1;
end