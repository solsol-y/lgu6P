#ex_43.py

def op(x, z, y):
        return (x+y)*z

x = 2
y = 3
z = 4

#위치 인자 방식 호출
print( op(x, z, y))
print( op(2, 3, 4))

#키워드 인자 방식 호출
print( op(x=x, y=y, z=z) )

#위차, 키워드 혼합 방식
print( op(x, y=y, z=z) )

#혼합일때 순서 잘못
#print( op(y=y, x, z) )


# def my_print(*args):   
#         print(args, type(args))

# my_print('a', 'b', 'c')  #위치인자로 인식


# def my_print2(**kwargs):
#         print(kwargs, type(kwargs))
# my_print2(x='a', y='b', z='c') #키워드 인자를 딕션너리로 이해





def add_all(*args,**kwargs):
    print(args,kwargs)  # 튜플 형태로 저장됨
    return sum(args)

print(add_all(1, 2, 3, 4, 5,6,6,7,x=100,y=200))  


