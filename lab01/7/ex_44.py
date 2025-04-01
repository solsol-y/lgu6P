#ex_44.py

# p = lambda x,y : x + y
# p(3,4)

# # #위와 아래 코드와 동일함
# # def plus(x, y)
# #         return x + y
# # plus(3,4)


operations = {
    '+': lambda x, y: x + y,
    '-': lambda x, y: x - y,
    '*': lambda x, y: x * y,
    '/': lambda x, y: x / y if y != 0 else "오류: 0으로 나눌 수 없습니다"
}

# 두 수와 연산자를 사용자로부터 입력받고
# 입력된 연산을 operaions를 이용하여 수행하기
# print( operations['+'](10,2))

a = int(input("첫번째 숫자를 입력하세요:"))
b = int(input("두번째 숫자를 입력하세요:"))
op = input("연산자를 입력하세요(+,-,*,/):")

if op in operations.keys():
        result = operations[op](a,b)
else:
        "오류 : 계산할 수 없는 연산자입니다."      

# d = operations[op](a,b)
# print(a,op,b ,"=", d)
# print(d)
print(result)
