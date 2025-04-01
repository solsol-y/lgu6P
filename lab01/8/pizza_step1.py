# pizza_step1.py

# def main():
print("빅데이터 피자 가게에 오신것을 환영합니다.")

menus = ['페페로니 피자','스테이크 피자', '시푸드 피자']
price = [29000, 32000, 32000]
order = []


while True:
        print("피자를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

        for i in range(len(menus)):
                print(f"{i+1}. {menus[i]} ({price[i]}원)")
        a = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
        if a.isdigit() == True and int(a) < 4 :
                order.append(menus[int(a)-1])
        elif a == "f":
                print(f"주문내역 :\n{order}")
                break
        else :
                print("주문오류.\n다시 입력해주세요.")   
                continue