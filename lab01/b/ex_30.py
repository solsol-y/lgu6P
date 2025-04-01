#ex_30.py

# n=5
# for i in range(n):
#         for j in range(n-i-1):
#                 print(' ',end='')
#         for j in range(2*i+1):
#                 print('*',end='')
#         print()

n=5
for i in range(n):
        print(f"{'*'*(2*i+1):^{2*n-1}}")















