import random
import numpy as np
from copy import deepcopy as dp
import time
from scipy import stats, integrate
import matplotlib.pyplot as plt
eps = 0.0000001
totExpo = 5/20


def getMoney(lastMoney, lastPeople):
    if (lastPeople == 1):
        return lastMoney, 0, 0
    minMoney = 0.01
    maxMoney = lastMoney-0.01*lastPeople+0.01
    random.seed()
    pred = (lastMoney/lastPeople)*2
    pred = random.random()*pred-0.01
    if (pred < minMoney+eps):
        pred = minMoney
    if (pred+eps > maxMoney):
        pred = maxMoney
    pred = int(pred*100)/100
    lastMoney = lastMoney - pred
    lastPeople = lastPeople - 1
    return pred, lastMoney, lastPeople


def getRedEnvelope(money, people):
    ans = np.zeros(people)
    x = (0, money, people)
    for i in range(people):
        x = dp(getMoney(x[1], x[2]))
        t = dp(round(x[0], 2))
        ans[i] = t
    if abs(sum(ans)-money) > eps:
        print("eeeeeeee,sb")
    return ans

if __name__ == '__main__':
    data = np.zeros([30, 20])
    varExample = np.zeros(30)
    avgExample = np.zeros(20)
    varPosition = np.zeros(20)
    max1 = 35
    pdfAvg = np.zeros(max1)
    cdf = np.zeros(max1)
    cdfAvg = np.zeros(max1)
    for i in range(30):
        data[i] = dp(getRedEnvelope(5.0, 20))/5.0
        pdf = np.zeros(max1)
        for j in range(20):
            t = int(data[i, j]*100)
            pdf[t] = pdf[t]+1
        for j in range(max1):
            if (j == 0):
                cdf[j] = pdf[0]
            if (j > 0):
                cdf[j] = cdf[j-1]+pdf[j]
        cdf = cdf/20
        pdfAvg = pdfAvg+pdf
        cdfAvg = cdfAvg+cdf
        avgExample = avgExample+data[i]
        varExample[i] = np.var(data[i])
    for i in range(20):
        tmp = np.zeros(30)
        for j in range(30):
            tmp[j] = data[j, i]
        varPosition[i] = np.var(tmp)
    avgExample = avgExample/30.0
    cdfAvg = cdfAvg/max1
    pdfAvg = pdfAvg/max1
    plt.bar([i for i in range(max1)], cdfAvg)
    p = np.polyfit([i for i in range(max1)], cdfAvg, 7)
    y2 = np.polyval(p, [i for i in range(max1)])
    plt.plot([i for i in range(max1)], cdfAvg,
             'o', [i for i in range(max1)], y2)
    # plt.bar([i for i in range(max1)], pdfAvg)
    # p = np.polyfit([i for i in range(max1)], pdfAvg, 7)
    # y2 = np.polyval(p, [i for i in range(max1)])
    # plt.plot([i for i in range(max1)], pdfAvg,
    #          'o', [i for i in range(max1)], y2)
    #plt.bar([i for i in range(1, 21)], avgExample)
    # plt.bar([i for i in range(1, 31)], varExample)
    # plt.bar([i for i in range(1, 21)], varPosition)
    plt.show()
    # print(varExample)
    # print(varPosition)
    # print(avgExample)
