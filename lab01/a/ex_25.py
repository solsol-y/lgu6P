#ex_25.py

passwd = 1234

Passwd = int(input("비밀번호를 입력하세요"))


for i in range(1,5):
    if Passwd!= passwd:
        Passwd = int(input(f"비밀번호를 다시입력하세요.\n 비밀번호 틀린 횟수{i}/5\n"))
    if i==4:
        print("비밀번호 횟수 초과")
    else:
        print("로그인성공")
        break
         
0