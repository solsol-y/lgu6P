#ex_48.py

# with open('file_w.txt','w', encoding='utf-8') as f: #utf-8 : 한글이 깨지지 않고 잘 읽히고 써지게 하는 인코딩 방식
#         # f.write("dafdasfasdf")
#         f.write("Hellow python\n")
#         f.write("안녕 파이썬")


# with open("file_w.txt","r", encoding="utf-8") as f:
#         lines = f.readlines()
#         print(lines, type(lines))
#         # for line in lines:
#         #         print(line, end='')

import ex_45  #다른 파일에 있는 데이터  불러오기

# ex_45.mean(), ex_45.std

# # #주석처리를 하면 안가져와진다.


with open('../data/jisoo.txt','w',encoding='utf-8') as f1:
        for num in [90,96,89,91]:
                f1.write(str(num)+ '\n')
with open('../data/mandoo.txt', 'w', encoding='utf-8') as f2:
        for num in [98,73,88,90]:
                f2.write(str(num)+ '\n')
import os
input_files = os.listdir('../data') #data 문서안에 있는 자료(폴더)들을 리스트화

# with open('../data/jisoo.txt' , 'r',encoding='utf-8') as f3:
#         lines = f3.readlines()
# jisoo=[int(line.strip()) for line in lines]
# ex_45.mean(jisoo)
# print(jisoo)
name = 0
with open('ex_48.txt','w') as fw:
        for file in input_files: #input_files의 각각의 자료(폴더) 낱개
                #print(file, type(file), file[-3:])
                if file[-5:] == 'o.txt':
                        # print(file)
                        name = file[:-4]
                        scores = []
                        with open(f"../data/{file}",'r',encoding='utf-8') as f4:
                                # # print(f4.readlines())
                                lines = f4.readlines()
                                # for line in lines:
                                #         scores.append(int(line))
                                # print(scores)
                                # print(ex_45.mean(scores), ex_45.std(scores))
                                scores = [int(line.strip()) for line in lines]
                                # print(ex_45.mean(f5), ex_45.std(f5))
                                a = ex_45.mean(scores)
                                b = ex_45.std(scores)

                                fw.write(f"{name:>10}:{a},{round(b,3)}")
                        

# for file in input_files:
#         with open(f'./data/{file}','r',encoding='utf-8') as f3:
#         # file= file 
        # print(type(file))


