#ex_45.py

# def convert_data(**kwargs):
#         Print(,kwargs)


def convert_data(product):
    result = {}
    for i in products:
            a={}
            b={}
            for j in i["items"]:
                    name=(j["name"])
                    price = j["price"]
                    stock = j["stock"]
                    
                    b = {"price" : price , "stock" : stock}
                    a ={name : b}
                    result.update(a)

    import pprint
    pprint.pprint(result)

    pass
products = [
    {
        "category": "Electronics",
        "items": [
            {"name": "Laptop", "price": 1200, "stock": 5},
            {"name": "Smartphone", "price": 800, "stock": 10}
        ]
    },
    {
        "category": "Home Appliances",
        "items": [
            {"name": "Vacuum Cleaner", "price": 150, "stock": 7},
            {"name": "Air Conditioner", "price": 500, "stock": 3}
        ]
    }
]

convert_data(products)

        # print(i)
        # print(i["items"])        
        




#문제 : 아래와 같이 정답이 나오도록 코드 작성하세요
# result = {
#     "Laptop": {"price": 1200, "stock": 5},
#     "Smartphone": {"price": 800, "stock": 10},
#     "Vacuum Cleaner": {"price": 150, "stock": 7},
#     "Air Conditioner": {"price": 500, "stock": 3}
# }


# def convert_data(products):
#     pass


