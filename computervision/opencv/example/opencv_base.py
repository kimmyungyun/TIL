import cv2
import numpy as np
## source : https://www.pyimagesearch.com/2018/07/19/opencv-tutorial-a-guide-to-learn-opencv/

image = cv2.imread("assets/iu.jpg")
# numpy array 와 같은 row_size, col_size, channel
(h, w, d) = image.shape

print(f"width={w}, height={h}, channels={d}")

# while True:
#     cv2.imshow("window", image)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# #특정 픽셀 값 가져오기
# (B, G, R) = image[100, 100]
# print(f"B = {B}, G = {G}, R = {R}")
#
# # ROI 크롭하기
# roi = image[70:140, 225:280]
# while True:
#     cv2.imshow("ROI", roi)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# #이미지 resize
# resized = cv2.resize(roi, (200, 200))
# while True:
#     cv2.imshow("resize", resized)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# # aspect ratio를 활용한 resize
# r = 300.0 / w
# size = (300, int(h * r))
# resized = cv2.resize(image, size)
# while True:
#     cv2.imshow("aspect ratio resize", resized)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# ## rotated img
# center = (w //2 , h//2)
# Mat = cv2.getRotationMatrix2D(center, -45, 1.0)
# rotated = cv2.warpAffine(image, Mat, (w, h))
# while True:
#     cv2.imshow("rotated img", rotated)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break

## 이미지 블러처리
# blurred_img = cv2.GaussianBlur(image, (11, 11), 0)
# while True:
#     cv2.imshow("blurred_img", blurred_img)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break

# 이미지에 직사각형 그리기
# output = image.copy()
# cv2.rectangle(output, (50, 50), (420, 160), (0, 0, 255), 2)
# while True:
#     cv2.imshow("rectangle", output)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# # 이미지에 원 그리기
# output = image.copy()
# cv2.circle(output, (50, 50), 20, (0, 0, 255), 2)
# while True:
#     cv2.imshow("circle", output)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break

# 이미지에 선 그리기
# output = image.copy()
# cv2.line(output, (50, 50), (70, 70), (0, 0, 255), 5)
# while True:
#     cv2.imshow("line", output)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# # 이미지에 텍스트 넣기
# output = image.copy()
# cv2.putText(output, "Practice Oepncv", (50, 50), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 255), 5)
# while True:
#     cv2.imshow("putText", output)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break

## canny 엣지를 활용한 엣지 추출
# img2 = cv2.imread("assets/polygon.png")
# gray_img = cv2.cvtColor(img2, cv2.COLOR_RGB2GRAY)
# edged = cv2.Canny(gray_img, 30, 150)
# while True:
#     cv2.imshow("edged_img", edged)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# ## 이진영상으로 변환
# thresh = cv2.threshold(gray_img, 225, 255, cv2.THRESH_BINARY_INV)[1]
# while True:
#     cv2.imshow("thresh_img", thresh)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break
#
# ## contours 추출
# ___, cont, hierachy  = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,
#                             cv2.CHAIN_APPROX_SIMPLE)
# result = img2.copy()
#
# ## contours 그리기
# cv2.drawContours(result, cont, -1, (122, 122, 122), 3)
# while True:
#     cv2.imshow("Contours", result)
#     c = cv2.waitKey(1)
#     if c == 27:
#         break

img3 = cv2.imread("assets/erode.png")
mask = cv2.erode(img3.copy(), None, iterations=5)
while True:
    cv2.imshow("erode", mask)
    c = cv2.waitKey(1)
    if c == 27:
        break

mask2 = cv2.dilate(mask.copy(), None, iterations=5)
while True:
    cv2.imshow("dilate", mask2)
    c = cv2.waitKey(1)
    if c == 27:
        break