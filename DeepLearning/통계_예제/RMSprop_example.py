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


cache = np.zeros(w.size)
decay_rate = 0.99
eps = 1e-8


def sigma(z):
    return 1 / (1 + np.exp(-z))


for epoch in range(EPOCH):
    # for each epoch, shuffle X, y
    shuffle(randRow)
    epochLoss = 0

    for i in range(0, rows, batch):
        batch_index = randRow[i:i + batch]
        x_batch = X[batch_index]
        y_batch = y[batch_index]
        #아직 진행 안함
        pass