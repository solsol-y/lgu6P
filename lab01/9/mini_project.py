#mini_project.py
import random 

class baseball:
        def __init__(self, a):
                self.a = int(random.randrange(100,1000))
                
                num = input("세자리 숫자를 입력하세요.\n")
                if num.isdigit() != False:
                        print("숫자만 입력해주세요.")
                        return
                num2 = int(num)

