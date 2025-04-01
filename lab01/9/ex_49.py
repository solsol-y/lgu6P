#ex_49.py

class BankAccount:
        def __init__(self,owner, pw, balance=0):
                self.owner = owner
                self.pw = pw
                self.balance =balance
                print(f"{owner}님의 계좌가 잔액{balance}원으로 개설되었습니다.")

        def deposit(self, amount):
                if amount >0:
                        self.balance += amount
                        print(f"{amount}원이 입금되었습니다.")
                else:
                        print("0보다 큰 금액을 입금해주세요.")
        def withdraw(self, amount, pw):
               
                if pw != self.pw:
                        print("비밀번호 오류")
                        return
                if amount <= self.balance:
                        self.balance -=amount
                        print(f"{amount}원 출금되엇습니다.")
                else:
                        print("잔액이 부족합니다.")
              

        def get_balance(self):
                p = int(input("비밀번호를 입력하세요"))
                if self.pw == p:
                        print(f"계좌의 현재 잔액은 {self.balance}원입니다.")

                else:
                        print("비밀번호 오류")

        def remittance(self, amount, account, pw):
                if pw != self.pw:
                        print("비밀번호 오류")
                        return
                if amount <= self.balance:
                        self.balance -= amount

                        print(f"{self.owner}님 계좌로 {amount}원 송금합니다.")
                else:
                        print("잔액이 부족합니다.")


                # amount 만큼 금액 차감
                self.withdraw(amount, pw)
               
                # amount만큼 account에 입금            
                self.deposit(amount)
#계좌생성
account1 =BankAccount("홍길동", 1234, 1000)
account1.deposit(5000)
account1.get_balance()

account1.withdraw(1000,1234)
account1.get_balance()

account2 = BankAccount("김길동", 1234, 10000)
account2.get_balance()

account2.remittance(5000, account1, 1234)
account1.get_balance()