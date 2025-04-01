# pizza_step2.py

print("빅데이터 피자 가게에 오신것을 환영합니다.")

menus = ['페페로니 피자','스테이크 피자', '시푸드 피자']
토핑 = ['햄', '페퍼로니', '트러플', '올리브', '새우']

price = {'피자':[29000, 32000, 32000],'토핑':[500, 500, 800, 300, 800]}
order_pizza=[]
order_toping=[]
order = {}
전체주문=[]
def 피자주문(l):
        while True:
                print("피자를 선택하세요. 수량 추가를 위해 여러번 선택 가능합니다.")

                for i in range(len(menus)):
                        print(f"{i+1}. {menus[i]} ({price['피자'][i]}원)")
                a = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if a.isdigit() == True and int(a) < 4 :
                        order_pizza.append(menus[int(a)-1])
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

                for j in range(len(토핑)):
                        print(f"{j+1}. {토핑[j]} ({price['토핑'][j]}원)")
                b = input("번호를 입력하고 Enter를 누르세요.(주문완료는 f를 누르세요.): ")
                if b.isdigit() == True and int(b) < 6 :
                        order_toping.append(토핑[int(b)-1])
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

피자주문(전체주문)
토핑주문(전체주문)


