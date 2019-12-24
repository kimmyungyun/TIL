import numpy as np
import pandas as pd
from numpy.random import shuffle, rand
import statsmodels.api as sm
import matplotlib.pyplot as plt
from sklearn.datasets import make_classification

X, y = make_classification(n_features=4, n_redundant=0, n_informative=1,
                           n_clusters_per_class=1, random_state=4)


EPOCH = 50000  # 50000
batch = 34
# lrs = [0.0005, 0.00005, 0.00001]
lr = 0.00005
rows = X.shape[0]
losses = []
randRow = np.arange(rows)
m = 0.95

w = rand(X.shape[-1]) - 0.5
v = np.zeros(w.shape)

def sigmoid(x):
    return 1 / (1 +np.exp(-x))


for epoch in range(EPOCH):
    # for each epoch, shuffle X, y
    shuffle(randRow)
    epochLoss = 0
    #     if epoch < 50000:
    #         lr = lrs[0]
    #     elif epoch < 100000:
    #         lr = lrs[1]
    #     else: lr = lrs[2]
    loss = 0
    for i in range(0, rows, batch):
        batch_index = randRow[i:i + batch]
        x_batch = X[batch_index]
        y_batch = y[batch_index]
        # 아래는 직접 구현해보세요.
        P_x = sigmoid(np.dot(x_batch, w))

        dw = (m*v)-(lr*np.dot(x_batch.T, (P_x - y_batch)))
        loss += -1*np.dot(y_batch.T, P_x) - (np.dot((1-y_batch).T, (1-np.log(P_x)) ))
        w += dw
        v = dw
    loss /= rows
    losses.append(loss)
    if epoch%100 == 0:
        print(f"epoch: {epoch}, loss:{loss}")
print(f"weight : {w}")

from sklearn.metrics import accuracy_score

predict_x = np.dot(X, w)
result = np.zeros(len(predict_x))
for idx, i in enumerate(predict_x):
    if i < 0:
        result[idx] = 0
    elif i >= 0:
        result[idx] = 1

score = accuracy_score(result, y)
print(score)
losses = pd.DataFrame(losses)
losses[10000:].plot()
plt.show()
print("")