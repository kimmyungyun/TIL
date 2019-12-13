import requests
from bs4 import BeautifulSoup

url = 'https://www.naver.com'
res = requests.get(url)
soup = BeautifulSoup(res.text, 'html.parser')

data = soup.select(".ah_l")
# datas = data.select(".ah_l")
print(data[0].select(".ah_k"))

datas = data[0].select(".ah_k")

for i in datas:
	print(i.text)
	print("="*30)