#ex_38.py

data=[
{'name':'철수', 'math':85, 'eng':90, 'sci':75},
{'name':'준호', 'math':73, 'eng':85, 'sci':93},
{'name':'영희', 'math':92, 'eng':88, 'sci':90}
]


성적 = {}

for i in data:
        이름 = i['name']
        총점 = i['math'] +i['eng']+i['sci']
        평균 = round(총점/3,2)
        성적[이름] = [총점, 평균]
print(성적)





