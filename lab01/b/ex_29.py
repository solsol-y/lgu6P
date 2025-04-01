#ex_29.py

for i in range(5):
        print('*'*(5-i))
# 역으로 *이 4개부터 나오게 만드는 법



n =5
for i in range(n):
        for j in range(n-i):
                print('*', end='')
        print()
 #이중 역으로     
