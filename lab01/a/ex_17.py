# ex_17.py

height = float(input("키(m): "))
weight = float(input("몸무게(kg): "))

bmi = weight/height**2

if bmi < 18.5:
    print("저체중","BMI: ", bmi)
elif 18.5 <= bmi < 23:
    print("정상","BMI: ", bmi)
elif 23<= bmi < 25:
    print("과체중","BMI: ", bmi)
#elif 23 <= bmi and bmi < 25:
else:
    print("비만","BMI: ", bmi)

# if a > 0:
#     print("positive")
# elif a < 0:
#     print("negative")
# else : 
#     print("zero")

