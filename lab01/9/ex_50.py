#ex_50.py

import random

class Linear:
        def __init__(self, input_dim, output_dim): #입력 및 결과의 열의 갯수
                #random.random() 0 ~ 1 사이의 랜덤한 실수/ 가중치를 무작위로 초기화 할때 사용
                # self.weight = [[], [], ...] #in_feature행, out_feature열
                # self.weight = [ 
                #         [random.random(), random.random()],
                #         [random.random(), random.random()],
                #         [random.random(), random.random()] #input_dim 행, output_dim 열
                # ]
                self.weight =[]
                for i in range(input_dim):
                      row = []
                      for j in range(output_dim):
                        row.append(random.random())
                        self.weight.append(row)

                self.bias = []
                for k in range(output_dim):
                      self.bias.append(random.random())


                # self.bias = [] # out_feature개
                # self.bias = [random.random(), random.random()]

        # def matmul(self, A, B):

        #         C = []
        #         for i in range(len(A)):
        #                 D = []
        #                 for j in range(len(A[i])):
        #                         H=0
        #                         for k in range(3):
        #                                 G = A[i][k]*B[k][j]
                        
        #                         H += G
        #                 D.append(H)
        #         C.append(D)
 
        #         return C                     
                        # H += A[i][k]*B[k][j]
        #         #행렬곡 A, B를 해서
        #         #결과행렬 C를 반환


        def forward(self, x):
                result = []
                for row in x : # x안의 1행에 해당하는 값[[]]
                      output_row = []
                      for i in range(len(self.bias)):
                            sum_value = 0
                            for j in range(len(row)): #열의 갯수
                                sum_value += row[j] * self.weight[j][i] #[i][j]의 값
                                sum_value += self.bias[i]
                            output_row.append(round(sum_value,4))
                      result.append(output_row)
                return result

        # def forward(self, x):
        #         # self.x = x * self.weight + self.bias
        #         # x * self.weight +self.bias
        #         Z = self.matmul(x, self.weight)
        #         y = Z + self.bias

        #         return y


linear = Linear(3,2)  #(a,b)일때 결과는 (b,b)
x =[ [1,2,3],
    [4,5,6]]

print( linear.forward(x)) # 결과는 2행2열

                # self.input_dim = input_dim
                # self.output_dim = output_dim
