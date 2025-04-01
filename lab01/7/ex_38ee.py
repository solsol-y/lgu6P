#ex_38ee.py

orders = [
    {
        "country": "USA",
        "customers": [
            {
                "customer_id": "C001",
                "orders": [
                    {"product": "Laptop", "quantity": 1, "unit_price": 1200},
                    {"product": "Mouse", "quantity": 2, "unit_price": 25}
                ]
            },
            {
                "customer_id": "C002",
                "orders": [
                    {"product": "Smartphone", "quantity": 1, "unit_price": 800}
                ]
            }
        ]
    },
    {
        "country": "Canada",
        "customers": [
            {
                "customer_id": "C003",
                "orders": [
                    {"product": "Laptop", "quantity": 2, "unit_price": 1150},
                    {"product": "Keyboard", "quantity": 1, "unit_price": 100}
                ]
            }
        ]
    }
]

# def order_by_customers(orders):

def A(orders):
        result={}
        for i in orders:
                c= i["country"]
                
                for j in i["customers"]:
                        a = {}
                
                        b=0
                        d=[]
                        for k in j["orders"]:
                        
                                d.append(k["product"])    #Laptop, mouse
                                b += k["quantity"]*k["unit_price"] #총 가격
                                

                        a["country"] = c
                        a["products"] = d
                        a["total_amount"] = b
                        result[j["customer_id"]] = a   # j["customer_id"] #COO1
                

        import pprint
        pprint.pprint(result)

        pass

A(orders)

           

#     pass

result = {
    "C001": {
        "country": "USA",
        "products": ["Laptop", "Mouse"],
        "total_amount": 1250  # (1 x 1200) + (2 x 25)
    },
    "C002": {
        "country": "USA",
        "products": ["Smartphone"],
        "total_amount": 800
    },
    "C003": {
        "country": "Canada",
        "products": ["Laptop", "Keyboard"],
        "total_amount": 2400  # (2 x 1150) + (1 x 100)
    }
}

