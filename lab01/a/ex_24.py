#ex_24.py


# PW = 1234
# passwd =int(input("비밀번호를 입력하세요"))

# while passwd!= PW:
#     passwd =int(input("비밀번호를 다시 입력하세요"))
#     if passwd == PW:
#         break
# print("로그인성공")



pw=1234
Pw= int(input("비밀번호를 입력하세요\n"))
for i in range(1,5,1):
    if pw!=Pw:
        Pw= int(input(f"비밀번호를 다시입력하세요.\n로그인 횟수가 {5-i}회 남았습니다.\n"))
        if i==4:
            print("로그인 실패 아이디가 잠겼습니다.")

    else:
        print("로그인 성공")
        break