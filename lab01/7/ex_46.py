#ex_46.py

import random


# lottery = []

# while len(lottery) < 6:

#         n = random.randrange(1,46)
#         if n not in lottery:
#                 lottery.append(n)

# print(lottery)



N = int(input("몇 게임?"))


lot=[]
for i in range (N):
        lottery = []
        while len(lottery) < 6:

                n = random.randrange(1,46)
                if n not in lottery:
                        lottery.append(n)
        lot.append(lottery)
print(lot)



        




