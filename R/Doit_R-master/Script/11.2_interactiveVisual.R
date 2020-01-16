### Interactive Plotting in R ##########################

## 1. googleVis 활용

# 1) 과일별 연간 비용/매출/수익 분포.
install.packages("googleVis")
library(googleVis)
example(googleVis)
demo(googleVis)
demo(package='googleVis')
demo(AnimatedGeoChart)

data("Fruits")
head(Fruits)
str(Fruits)
t1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar = "Year")
plot(t1)

# 2) 사내 데이터 분석.
## 2-1) excel에서 data 훑어보기

# `YYYYMM` DATE NOT NULL COMMENT '기준연월', 
# `ORDER_NO` INT(11) UNSIGNED NOT NULL COMMENT '오더번호',
# `ORDER_TYPE` VARCHAR(50) NOT NULL COMMENT '오더유형명',
# `COURSE_CODE` VARCHAR(4) NOT NULL COMMENT '과목코드',
# `COURSE_NAME` VARCHAR(20) NOT NULL COMMENT '과목명',
# `FVISIT_DATE` VARCHAR(20) NOT NULL COMMENT '첫수업일',
# `HO_SEQ` INT(11) NOT NULL COMMENT '학습호_seq',
# `PLAN_TAG` CHAR(1) NOT NULL COMMENT '학습계획여부',
# `TOGETHER_TAG` CHAR(1) NOT NULL COMMENT '투게더참여여부',
# `W_RATE` FLOAT UNSIGNED NOT NULL COMMENT '학습완료율',
# `G_TOC_CNT` INT(11) UNSIGNED NOT NULL COMMENT '계획모듈/목차의 수',
# `W_TOC_CNT` INT(11) UNSIGNED NOT NULL COMMENT '완료모듈/목차의 수',
# `M_TOC_CNT` INT(11) UNSIGNED NOT NULL COMMENT '미완료모듈/목차의 수',
# `G_PBLM_CNT` INT(11) UNSIGNED NOT NULL COMMENT '계획된문항수',
# `H_PBLM_CNT` INT(11) UNSIGNED NOT NULL COMMENT '학습한문항수',
# `S_PBLM_CNT` INT(11) UNSIGNED NOT NULL COMMENT '맞힌문항수

## 검토 결과리 - EDA task 도출.
# 2016-10-01자료만 있다.
# 각 orderid에 ordertype은 오직 하나다.
# 과목코드와 과목명은 1:1 대응한다.
# 각 orderid에 
# 학습계획이 없으면, 완료율이나 계획수 등이 모두 0 - 의미없다.
# 투게더 참여하면, 완료율이 상태적으로 높다. 얼마나?

## 2-2) raw data 읽기.
# data <- read.csv(“datafile.csv”, header=T)
install.packages("xlsx")
library(xlsx)
setwd("C://edu//r")
getwd()
# data<- read.xlsx("WJbt.xlsx", sheetIndex = 1, header=T) #멈춤-xlsx2를 사용해야
data<- read.xlsx2("hadoop_R_data.xlsx", sheetIndex = 1, 
                  header=T, stringsAsFactors=F)
head(data)
str(data)

## 2-3) 데이터 전처리
for(i in 11:16){
  data[,i] = as.integer(data[,i])
}

data[,6] = as.Date(data[,6], format='%Y%m%d')
data[,1] = as.Date(as.integer(data[,1]), origin="1899-12-30")
data[,10] = as.numeric(data[,10])
for(i in (3:9)[-4]){
  data[,i] = as.factor(data[,i])
}

# N -> 0, Y -> 1
for(i in (8:9)){
  data[,i] = as.integer(data[,i])-1
}
str(data) # 전처리 결과 확인

## 2-4) EDA 1: 과목별 확습완료율에 대한 시간적 변화
# 필요 데이터: 학습계획이 있는 data만 사용

tb1 <- gvisMotionChart(data, idvar="COURSE_CODE", timevar = "FVISIT_DATE",
                      colorvar = "COURSE_CODE")
# Error: The data must have rows with unique combinations of idvar and timevar.

# EDA-1을 위한 추가 전처리
library(sqldf)
library(tcltk)
dataEDA1 <- sqldf("select COURSE_CODE, FVISIT_DATE, avg(W_RATE) as CompeleRate, 
                  sum(TOGETHER_TAG)/count(*) as TogetherRate from data
                  where PLAN_TAG = 1 group by COURSE_CODE, FVISIT_DATE
                  order by COURSE_CODE, FVISIT_DATE")
head(dataEDA1)
str(dataEDA1)

tb1 <- gvisMotionChart(dataEDA1, idvar="COURSE_CODE", damevar = "FVISIT_DATE", 
                       colorVar = "COURSE_CODE", date.format="%Y/%m/%d")
plot(tb1)

## 2. manipulate 활용.
library(MASS) # 현대 응용통계를 위한 함수 집합.
data(Cars93) # MASS에 내장된 자동차 데이터
str(Cars93)
# 차종(Type), 가격(Price), 고속도로연비(MPG.highway), 무게(Weight) 변수를 사용

install.packages("manipulate")
library(manipulate)
example(manipulate)
# example("plot.hclust")

# 1) Slider Control
# - slider(start point, end point, step=, initial=)로 slinding 옵션을 설정.
# - 옵션 객체를 그래프의 조작하고자 하는 부분에 할당
# - 예: 히스토리그램의 bin size를 3 ~ 100, 5씩 증가. initial은 20
manipulate(hist(Cars93$Price, breaks = bin_slider),
           bin_slider=slider(5, 100, step=5, initial=20))

# 2) Picker Control
# 히스토그램의 대상 변수를 동적으로 선택.
(hVar = names(Cars93)[c(5,8,25)]) #Vector로 전달하면 에러발생.
str(hVar)
(pV<-as.list(hVar)) #list로 전달해야 처리된다.
# - "MPG.highway", "Weight", "Price" 값은 내부적으로 list로 전달된다.
manipulate(hist(Cars93[, tempVar], freq= FALSE, main= tempVar),
           tempVar = picker("MPG.highway", "Weight", "Price"))
manipulate(hist(Cars93[, tempVar], freq= FALSE, main= tempVar),
           tempVar = picker(hVar))
manipulate(hist(Cars93[, tempVar], freq= FALSE, main= tempVar),
           tempVar = picker(pV))
manipulate(hist(Cars93[, tempVar], breaks = bin_slider,
                freq= FALSE, main= tempVar),
           bin_slider=slider(5, 100, step=5, initial=20),
           tempVar = picker(pV))

# 차종별 MPG와 Weight간 산포를 보자.
tb = table(Cars93$Type)
str(tb)
dimnames(tb)
cartype=as.list(dimnames(tb)[[1]])

manipulate(plot(MPG.highway ~ Weight, data=Cars93[Cars93$Type == type,]),
           type = picker(cartype))
# - van은 확실히 무게랑 연비가 큰 상관이 없어 보인다.

# 3) Checkbox Control
manipulate(boxplot(Price~Type, data=Cars93, outline=ol),
           ol = checkbox(F, "show outliers"))


## 3. shiny - web에서 활용

# 1) 개요
# ui에서 input과 output으로 반응형 입출력을 지정하고 
# sever에서 인자인 input() 함수와 output()함수를 조립하여 
# renderPlot()로 출력하게 됩니다.


## 1-1) ui.R 구조
# ui <- fluidPage(
#   headerPanel(), sidebarPanel(), mainPanel() )

# headerPanel() : 브라우저의 탭의 제목과 실제 페이지의 제목등으로 사용
# sidebarPanel() : 여러 입력용 함수들을 포함하고, 입력용 인터페이스를 만든다
# mainPanel() : 여러 출력용 함수들을 포함하고, 서버로부터 넘어온 결과를 출력

## 1-2) sever.R조 구조
# shinyServer <- function(input, output){}

# 2) 패키지 설치 및 템플릿 코딩.
install.packages("shiny")
library(shiny)
?fluidPage
example("fluidPage")

runExample() ## shiny패키지의 예시 앱의 목록을 보여줌
runExample("02_text") ## 02_text 앱을 실행

## shiny templete 시작.
# library(shiny)
# ui <- fluidPage()
# server <- function(input, output){}
# shinyApp(ui=ui, server=server)
## shiny templete 끝.

o
## 3) fluidPage()로 ui를 설정.
library(shiny)
ui <- fluidPage(
  headerPanel('Iris k-means clustering'),  
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected = names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),  
  mainPanel(    
    plotOutput('plot1')    
  )  
)

library(stats) #kmeans함수 사용.
# reactive는 시간에 따라 그 결과가 변할 수 있는 표현식을 생성.
server <- function(input, output) {
  selectedData <- reactive({    
    iris[, c(input$xcol, input$ycol)]    
  })
  clusters <- reactive({    
    kmeans(selectedData(), input$clusters)    
  })
  output$plot1 <- renderPlot({    
    par(mar = c(5.1, 4.1, 0, 1))    
    plot(selectedData(),         
         col = clusters()$cluster,         
         pch = 20, cex = 3)    
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)    
  })
}
shinyApp(ui = ui, server = server)


## 4. knitr
install.packages("knitr")
