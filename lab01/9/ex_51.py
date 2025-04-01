#ex_51.py

a = input("콤마(,) 혹은 공백으로 연결해서 여러 자연수를 입력하세요:")

# b = a.replace(',',' ')
# c= b.split()

L = [ int(i) for i in a.replace(',',' ').split()] # = c

def 평균(l):
        for i in range(len(L)):
                s = 0
                s += L[i]
        A = s/len(L)

        return A
A = 평균(L)

print(A)


