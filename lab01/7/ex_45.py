#ex_45.py


# import math as m
# l=[1,2,3,4,5,6]
# def std(l):
#         S = 0
#         s=0
#         a=0
#         y=0
#         z=0
#         for i in range(len(l)):
#                 S += l[i]
#                 y = S/len(l) #평균
#         for i in range(len(l)):
#                 s += (y - l[i])**2
#                 z = s/len(l) #분산
#         a = m.sqrt(z)
        
#         return(a)
# a=std(l)
# print(a)


import math as m
l=[1,2,3,4,5,6]
def mean(l):
        S = 0
        y=0
       
        for i in range(len(l)):
                S += l[i]
                y = S/len(l) #평균
        return y
y = mean(l)

def std(l):
        a = 0
        b=0
        for j in range(len(l)):
               a += (y-l[j])**2
        b = m.sqrt(a/len(l)) #표준편차
        return(b)
b = std(l)
print(y,b)






#ex_41.py

# L=[]
# x = 0
# y = 0
# for i in range(len(L)):
#         x += L[i]
#         y = x/len(L)
# print(y)
# L= [1,2]

# def mean(L):
#         x = 0
#         y = 0
#         for i in range(len(L)):
#                 x += L[i]
#                 y = x/len(L)
                
#         print(y)
#         return x,y
# x,y=mean([j for j in range(20)])
# print(x)
# print(y)
# mean([1,3,5])
