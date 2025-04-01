#ex_list.py

shoplist = ['apple', 'mango', 'carrot', 'banana']












#############################################################
#자주 쓰는 기능
##############################################################

# 특정 위치값 변경
shoplist[0] = 'melon'
#list는 가변이다. 0번째 목록 수정
print(shoplist)

# 마지막에 요소 추가
shoplist.append('lego')
# append : 리스트 뒤에 추가
print(shoplist)

# 리스트나 시퀀스 추가
shoplist.extend(['소고기', '닭고기'])
print(shoplist)
#extend는 리스트를 영구적으로 수정

print(shoplist +['소고기', '닭고기'])
print(shoplist)
#shoplist+[]는 일시적으로 수정하는것으로 print(shoplist)를 하면 원래의 리스트가 나옴

#제거 remove(value)



# 정렬
L = [3,5,8,5,6]
L.sort()#오름차순
print(L)
L.sort(reverse=True)#내림차순
print(L)

L_sorted = sorted(L, reverse=True)
print(L)
print(L_sorted)

