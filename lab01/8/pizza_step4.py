# pizza_step4.py


menus={
'피자': ['페퍼로니피자', '스테이크피자', '시푸드피자'],
'토핑': ['햄', '페퍼로니', '트러플', '올리브', '새우'],
'사이드': ['치즈오븐스파게티', '리조또', '치킨윙'],
'음료': ['콜라', '스프라이트', '오렌지쥬스']
}
prices={
'피자': [29000, 32000, 32000],
'토핑': [500, 500, 800, 300, 800],
'사이드': [9900, 8900, 8900],
'음료': [1000, 1000, 1000]
}



print("빅데이터 피자 가게에 오신것을 환영합니다.")

# menus = ['페페로니 피자','스테이크 피자', '시푸드 피자']
# 토핑 = ['햄', '페퍼로니', '트러플', '올리브', '새우']

# price = {'피자':[29000, 32000, 32000],'토핑':[500, 500, 800, 300, 800]}
order_pizza=[]
order_toping=[]
order_side=[]
order_drink=[]
order = {}
전체주문=[]
def 피자주문(l):
        while True:
                print("피자를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

                for i in range(len(menus['피자'])):
                        print(f"{i+1}. {menus['피자'][i]} ({prices['피자'][i]}원)")
                a = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if a.isdigit() == True and int(a) < 4 :
                        order_pizza.append(menus['피자'][int(a)-1])
                        order['피자']=order_pizza
                elif a == "n":
                        break
                elif a == "f":
                        print(f"주문내역 :\n{order}")
                        break
                else :
                        print("주문오류.\n다시 입력해주세요.")   
                        continue
        return(order,order_pizza)
def 토핑주문(l):
        while True:
                print("토핑를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

                for j in range(len(menus['토핑'])):
                        print(f"{j+1}. {menus['토핑'][j]} ({prices['토핑'][j]}원)")
                b = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if b.isdigit() == True and int(b) < 6 :
                        order_toping.append(menus['토핑'][int(b)-1])
                        order['토핑']=order_toping
                elif b == "n":
                        break
                elif b == "p":
                        피자주문(전체주문)
                elif b == "f":
                        print(f"주문내역 :\n{order}")
                        break
                else :
                        print("주문오류.\n다시 입력해주세요.")   
                        continue
        return(order,order_toping)
def 사이드주문(l):
        while True:
                print("사이드를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

                for j in range(len(menus['사이드'])):
                        print(f"{j+1}. {menus['사이드'][j]} ({prices['사이드'][j]}원)")
                b = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if b.isdigit() == True and int(b) < 4 :
                        order_side.append(menus['사이드'][int(b)-1])
                        order['사이드']=order_side
                elif b == "n":
                        break
                elif b == "p":
                        토핑주문(전체주문)
                elif b == "f":
                        print(f"주문내역 :\n{order}")
                        break
                else :
                        print("주문오류.\n다시 입력해주세요.")   
                        continue
        return(order,order_side)
def 음료주문(l):
        while True:
                print("음료를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

                for j in range(len(menus['음료'])):
                        print(f"{j+1}. {menus['음료'][j]} ({prices['음료'][j]}원)")
                b = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if b.isdigit() == True and int(b) < 6 :
                        order_drink.append(menus['음료'][int(b)-1])
                        order['음료']=order_drink
                elif b == "n":
                        break
                elif b == "p":
                        사이드주문(전체주문)
                elif b == "f":
                        print(f"주문내역 :\n{order}")
                        break
                else :
                        print("주문오류.\n다시 입력해주세요.")   
                        continue
        return(order,order_drink)
피자주문(전체주문)
토핑주문(전체주문)
사이드주문(전체주문)
음료주문(전체주문)
