import matlab.engine
#from get_schedule import main as get_calendar

person_id = 1
person = ['navneet','lars']

print('starting MATLAB engine')
mateng = matlab.engine.start_matlab()
eng_name = matlab.engine.find_matlab()
print('MATLAB engine {} started'.format(eng_name))


#load HMM data
mateng.load_file(person_id)

# record audio to process
test = mateng.APP()


print(test)