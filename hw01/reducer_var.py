#!/usr/bin/env python3

import sys

for line in sys.stdin:
        count, mean, var = [float(x) for x in line.split()]
        break

for line in sys.stdin:
        count_1, mean_1, var_1 = [float(x) for x in line.split()]
        count_2 = count + count_1
        var_res = ((count*var + count_1*var_1) / count_2) + count * count_1 * ((mean - mean_1)/count_2)**2
        count, mean, var = count_1, mean_1, var_res

print(var)