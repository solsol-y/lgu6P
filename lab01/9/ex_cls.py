#ex_cls.py

class Person:
        def __init__(self, name, height, weight):
                self.name = name
                self.height = height
                self.weight = weight

        def speed(self):
                return (self.height / self. weight) * 5
        
        def print(self):
                print(f"나는 {self.name}이고 키{self.height}입니다")
        

p1 = Person("Tom", 170, 100)
print(type(p1))
print(p1.name, p1.height, p1.weight)

     
        

p2 = Person("Kim", 180, 85)
print(p2.name, p2.height, p2.weight)

print(p1.speed())
print(p2.speed())


# p1 = {
#         'name' : 'Tom',
#         'height' : 170,
#         'weight' : 100
# }
