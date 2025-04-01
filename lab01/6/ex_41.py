#ex_41.py

# L=[]
# x = 0
# y = 0
# for i in range(len(L)):
#         x += L[i]
#         y = x/len(L)
# print(y)
L= [1,2]

def mean(L):
        x = 0
        y = 0
        for i in range(len(L)):
                x += L[i]
                y = x/len(L)
        print(y)
        return x,y
x,y=mean([j for j in range(20)])
print(x)
print(y)
mean([1,3,5])



