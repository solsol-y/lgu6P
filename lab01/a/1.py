# #ex_14.py

# a = int(input("원의 반지름을 입력하세요:"))
# b = 3.14
# print(f"반지름이 {a}인 원의 면적은 {b*a**2}입니다.\n\
# 이 원의 둘레는 {2*b*a}입니다.\n\
# 이 원의 지름은 {2*a}입니다.")


#ex_15.py

a = float(input("x = ?\n"))
b = float(input("y = ?\n")) # y는 뮤
c = float(input("z = ?\n")) # z는 시그마

d = 1/(c*2.506)*(2.718**(-((a-b)**2)/(2*c**2)))

print(round(d,3))



