# #ex_35.py

# # mylist =['dd', 'aa', 'cc']
# # print(''.join(mylist))

A = [[1,0,1], [0,2,0], [1,2,1]]
B = [[2,3,1], [0,1,1], [1,1,1]]
C=[]
# #C = [A[0][0]+B[0][0]]

# for i in range(len(A)):
#         D=[]
#         for j in range(len(A[i])):        
#                 D.append(A[i][j]+B[i][j])
#         C.append(D)
                
# print(C)



A = [[1,2,3], [4,5,6], [7,8,9]]
B = []

# #[2*A[0,0], 2A[0][1]

# for i in range(len(A)):
#         C = []
#         for j in range(len(A[i])):
#                 D = 2 * A[i][j]
#                 C.append(D)
#         B.append(C)
                
# print(B)


for row in A:
        t = []
        for num in row:
                t.append(num*2)
        B.append(t)
print(B)


# A에 각 요소마다 2를 곱해서 B 그룹을 만드는 코드








# C=[]
# for i in range(len(A)):
#         C.append(A[i][i]+B[i][i])

# D=[]
# for i in range(len(A)):
#         D.append(A[i][i]+B[i][i])

# E=[]
# for i in range(len(A)):
#         E.append(A[i][i]+B[i][i])

# F=[C,D,E]
# print(F)