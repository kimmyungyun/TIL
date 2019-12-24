import numpy as np
from numpy.random import shuffle, rand
import statsmodels.api as sm
from sklearn.datasets import make_classification

X, y = make_classification(n_features=4, n_redundant=0, n_informative=1,
                           n_clusters_per_class=1, random_state=4)

EPOCH = 150000  # 50000
batch = 34  # 2^n이 좋으나 데이터가 100개라 1/3로 함
lrs = [0.0005, 0.00005, 0.00001]
rows = X.shape[0]
losses = []
randRow = np.arange(rows)


X = sm.add_constant(X)
print(X.shape)
print(X[:5])


np.random.seed(234)
w = rand(X.shape[-1]) - 0.5
print(w)

def sigmoid(x):
    return 1 / (1 +np.exp(-x))

for epoch in range(EPOCH):
    # for each epoch, shuffle X, y
    shuffle(randRow)
    epochLoss = 0
    if epoch < 50000:
        lr = lrs[0]
    elif epoch < 100000:
        lr = lrs[1]
    else:
        lr = lrs[2]

    loss = 0
    for i in range(0, rows, batch):
        batch_index = randRow[i:i + batch]
        x_batch = X[batch_index]
        y_batch = y[batch_index]

        # 아래는 직접 구현해보세요.
        P_x = sigmoid(np.dot(x_batch, w))
        loss += -1*np.dot(y_batch.T, P_x) - (np.dot((1-y_batch).T, (1-np.log(P_x)) ))
        dw = np.dot(x_batch.T, (P_x - y_batch))
        w -= lr * dw
    loss /= rows
    print(f"epoch: {epoch}, loss:{loss}")
print(f"weight : {w}")

from sklearn.metrics import accuracy_score
predict_x = np.dot(X, w)
result = np.zeros(len(predict_x))
for idx, i in enumerate(predict_x):
    if i<0:
        result[idx] = 0
    elif i>=0:
        result[idx] = 1

score = accuracy_score(result, y)
print(score)