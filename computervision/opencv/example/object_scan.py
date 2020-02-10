import numpy as np
import cv2

img = cv2.imread("assets/bill.jpg")
gray_img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
gausian = cv2.GaussianBlur(gray_img, (7, 7), 0)

# edge detection
edged = cv2.Canny(gausian, 75, 200)
dilate = cv2.dilate(edged, (13, 13))

while True:
    cv2.imshow("edged", dilate)
    c = cv2.waitKey(1)
    if c == 27:
        break

__, contours, hier = cv2.findContours(dilate.copy(), cv2.RETR_LIST,
                            cv2.CHAIN_APPROX_SIMPLE)
contours = sorted(contours, key = cv2.contourArea, reverse = True)[:5]
print("HH")
result = img.copy()
for cont in contours:
    # 컨투어의 둘레의 길이를 구한다
    peri = cv2.arcLength(cont, True)
    approx = cv2.approxPolyDP(cont, 0.02 * peri, True)
    if len(approx) == 4:
        screenCnt = approx
        break

cv2.drawContours(result, [screenCnt], -1, (0, 255, 0), 2)
while True:
    cv2.imshow("cont", result)
    c = cv2.waitKey(1)
    if c == 27:
        break

pts1 = np.array(screenCnt.reshape(-1, 2), dtype="float32")
result2 = img.copy()

for pt in pts1:
    q = tuple(pt)
    cv2.circle(result2, q, 20, (255, 0, 0), -1)

while True:
    cv2.imshow("result2", result2)
    c = cv2.waitKey(1)
    if c == 27:
        break

# 좌표의 이동점
pts1 = np.array(screenCnt.reshape(-1, 2), dtype="float32")
# 좌표 순서 맞추기, 좌상 -> 좌하-> 우상-> 우하
pts1 = np.array([pts1[1, :], pts1[2,:], pts1[0, :], pts1[3, :]])
pts2 = np.float32([[0,0],[0,500],[500,0],[500,500]])

# pts1 -> pts2 변환 행렬 찾기
M = cv2.getPerspectiveTransform(pts1, pts2)

# 찾은 행렬로 이미지 변환
dst = cv2.warpPerspective(img, M, (500, 500))

while True:
    cv2.imshow("dst", dst)
    c = cv2.waitKey(1)
    if c == 27:
        break
