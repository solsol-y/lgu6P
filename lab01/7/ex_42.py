#ex_42.py



X = [[78, 80, 95, 55, 67, 43], \
     [45, 67, 90, 87, 88, 93]]

# AVG = [ round( mean(x),2 ) for x in X]

# AVG = []
# for x in X:
#         m = mean(x)
#         print(m)
#         AVG.append( round(m,2))








Y=[]
for i in range(len(X)):
        S = 0
        m = 0
        L = [n for n in X[i]]
        for j in range(len(L)):
                S += L[j]    
        m = round(S/(len(L)),2)
        Y.append(m)
print(Y)


