#ex_23.py

id = "python"
passwd = "abcd"
Id=(input("아이디를 입력하세요"))
if Id == id:
    Passwd =(input("비밀번호를 작성하세요"))
    if passwd==Passwd:
        print("로그인 성공")
    else:
        print("비밀번호가 잘못되었습니다.")
else:
    print("아이디가 존재하지 않습니다.")

    