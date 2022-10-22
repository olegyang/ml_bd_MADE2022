#!/usr/bin/env python3

import sys

for line in sys.stdin:
        count, mean =[float(x) for x in line.split()]
        break

for line in sys.stdin:
        count_1, mean_1 = [float(x) for x in line.split()]
        mean_res = (count*mean + count_1*mean_1) / (count + count_1)
        count, mean = count_1, mean_res

print(mean)
