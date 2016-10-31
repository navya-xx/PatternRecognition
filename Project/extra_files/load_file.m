function load_file(id)
    person = ['navneet','lars'];
    load(strcat('TrainedHMM-2Wordlength2States-recTr12-002sec_',person(id),'.m'));
end