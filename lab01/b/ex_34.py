#ex_34.py

numbers = [10,4,5,-1,6,12,40]

# S=sum(numbers[::2])
# print(S)
# #홀수

# S=sum(numbers[1::2])
# print(S)
# #짝수

f = numbers[1::2]

S = 0
for i in range(len(f)):
        S += f[i]
print(S)

# S = 0
# for i in range