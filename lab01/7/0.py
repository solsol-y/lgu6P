# for i in range(1,4):
#         for j in range(1,4):
                
#                 for k in range(1,4):
#                         print(i,j,k)

import random as m

n = m.randrange(1,101)


C=0
while True:    #정답을 맞힐 때까지 계속 반복

        i = input("숫자 한개를 입력하세요.")

        if not i.isdigit():
                print("숫자만 입력 가능합니다.")
                continue  #처음으로 돌아가서 입력 받기

        j = int(i)

        C += 1

        if j > n:
                print("너무 큽니다.")
               
        elif j<n:
        
                print("너무 작습니다.")
               
        
        else:
                print(f"정답입니다! {C}번 만에 맞혔습니다.")
                break





# 컴퓨터가 1부터 100 사이의 랜덤한 숫자를 하나 정한다.
# 사용자는 숫자를 맞힐 때까지 계속 입력해야 한다.

# 사용자가 입력한 숫자가 정답보다 크면 "너무 큽니다!" 출력
# 사용자가 입력한 숫자가 정답보다 작으면 "너무 작습니다!" 출력
# 정답을 맞히면 "정답입니다! X번 만에 맞혔습니다!" 출력 후 종료
# 입력은 숫자만 가능해야 하며, 잘못된 입력(문자 등)이 들어오면 다시 입력받아야 함