import requests
from bs4 import BeautifulSoup
url = "https://finance.naver.com/sise/"

s = requests.get(url)