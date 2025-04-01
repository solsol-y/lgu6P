#ex_37.py

en2ko={
'book': '책',
'snake': '뱀',
'language': '언어'
}
ko2en = {}
ko3en = {}

for k, v in en2ko.items():
#         ko2en[v]= k
        
# print(ko2en) 


        ko3en = {v:k}

        ko2en.update(ko3en)
print(ko2en)