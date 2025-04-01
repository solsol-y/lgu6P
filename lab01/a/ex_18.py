# ex_18.py

number = int(input("숫자를 입력하세요: "))

if number <= 0:
    print("")
else:
    count = 0
    while number > 0:
        print(number)
        #print('현재 숫자: ',number)
        number -= 1
        count += 1

    print('반복 횟수:', count)
  



# i = 0

# while i < 10:
#     print(i)
#     #i = i + 1
#     i +=1

#     # if i== 5 :
#         break

#     print("end while")