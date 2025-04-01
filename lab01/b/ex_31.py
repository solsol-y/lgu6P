#ex_32.py

teams = ['타이거즈', '라이온즈', '트윈스', '베어스', '위즈', \
'랜더스', '자이언츠', '이클스', '다이노스', '히어로즈']



# for i in range(10):
#         print(i+1,"위",teams[i])


for  i, team in enumerate(teams):
        # enumerate : 열거하다
        # i, team 동시에 변수 지정
        print(f"{i+1}위 {team}")