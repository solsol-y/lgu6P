#ex_33.py

# jisoo = [90, 85, 93]
# mansoo = [78, 92, 89]

# total = []

# # for i in range(len(jisoo)):
# #         t = jisoo[i]+mansoo[i]
# #         total.append(t)

# # print(total)

# for score in jisoo:
#         total.append(score + mansoo[  jisoo.index(score)  ])

# print(total)

# #jisoo.index(score) : 지수의 점수리스트에서 score가 몇번째에 있는지
# # for i in range(3):
# #         print(jisoo[i]+mansoo[i], ' ',end='')

# #(), {}, [] 내부에서 들여쓰기 무시


# for i, score in enumerate(jisoo):
#         #i = jisoo.index(score)


score = [[90, 85, 93],
         [78, 92, 89],
         [50, 40, 30] ]

#score[0][0]+[1][0]+[2][0]

t = []
for i in range(len(score)):
        S=0
        for j in range(len(score[i])):
                k = score[j][i]
                S += k
        t.append(S)
print(t)









# t =[]
# for i in range(len(score)):
#         k=0
#         for j in range(len(score[i])):
#                 k += score[i][j]
#         t.append(k)

# print(t)

# #[[]]의 숫자를 더해서 [ , , ]이렇게 표현할때 코드
 







