#ex_36.py

A = [[1,0,1], [0,2,0], [1,2,1]]
B = [[2,3,1], [0,1,1], [1,1,1]]

C = []

#C[1][1] = A[1][1]*B[1][1]+A[1][2]*B[2][1]+A[1][3]*B[3][1]


for i in range(len(A)):
        D = []
        for j in range(len(A[i])):
                H=0
                for k in range(3):
                        G = A[i][k]*B[k][j]
                
                        H += G
                        # H += A[i][k]*B[k][j]
                D.append(H)
        C.append(D)
 
print(C)



# C=[]
# for i in range(3):#          i=0                  i=1 
#     D=[]
#     for j in range(3):
#         sum=0
#         for k in range(3):
#             sum+=(A[i][k]*B[k][j])
#         D.append(sum)
#     C.append(D)
# print(C)