import requests
from bs4 import BeautifulSoup

url = 'https://gist.github.com/eduChange-hphk/selector.html'
res = requests.get(url)
BeautifulSoup(res, 'html.parser')
print(res)
