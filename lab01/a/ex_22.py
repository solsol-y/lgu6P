#ex_22.py

# k = int(input("숫자를 입력하세요\n"))
# total = 0
# for i in range(1,k+1):
#     total=total+i
# print(total)


n = int(input())
S = 0
for i in range(1, n+1):
    print(f"합산 전 S:{S},i:{i}")
    S += 1
    print(f"합산 후 S:{S},i:{i}")
    print("========================")