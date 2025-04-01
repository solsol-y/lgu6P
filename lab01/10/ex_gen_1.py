#ex_gen_1.py

def get_number_generator(n):
        for i in range(n):
                print("before yield")
                yield i
                print("after yield")

number = get_number_generator(3)
print(next(number, 'end'))
print()

print(next(number, 'end'))
print()

print(next(number, 'end'))
print()



#무한 제너레이터
def inf_number_gen():
        i = 1

        while True:
                yield i
                i += 1

num = inf_number_gen()

print(type(num))
print(next(num))
print(next(num))


        