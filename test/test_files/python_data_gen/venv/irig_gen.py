import datetime
import time
dst_file = "irig_msg.txt"
f= open(dst_file,"w+")
f.close()
tot_num_of_msg = 20
skip_idx_frame = range(2 , 8)
reference_idx_list = [0, 9, 19, 29, 39, 49, 59, 69, 79, 89, 99]
t = datetime.datetime.now()
d_time = datetime.timedelta(seconds = 1)
high = "1111100000"
low = "1100000000"
reference = "1111111100"
test_fsm = False
for k in range(0, tot_num_of_msg):
    sec = t.second
    minute = t.minute
    hour = t.hour
    day = int(t.strftime("%j"))
    month = t.month
    year = t.year - 2000

    sec_ones = sec % 10
    sec_tens = int(sec / 10)

    minute_ones = minute % 10
    minute_tens = int(minute / 10)

    hour_ones = hour % 10
    hour_tens = int(hour / 10)

    day_ones = day % 10
    day_tens = (int(day / 10)) % 10
    day_hundreds = int(day / 100)

    year_ones = year % 10
    year_tens = int(year / 10)

    bin_sec_ones = '{0:04b}'.format(sec_ones)[::-1]
    bin_sec_tens = '{0:03b}'.format(sec_tens)[::-1]

    bin_min_ones = '{0:04b}'.format(minute_ones)[::-1]
    bin_min_tens = '{0:03b}'.format(minute_tens)[::-1]

    bin_hour_ones = '{0:04b}'.format(hour_ones)[::-1]
    bin_hour_tens = '{0:02b}'.format(hour_tens)[::-1]

    bin_day_ones = '{0:04b}'.format(day_ones)[::-1]
    bin_day_tens = '{0:04b}'.format(day_tens)[::-1]
    bin_day_hundreds = '{0:02b}'.format(day_hundreds)[::-1]

    bin_years_ones = '{0:04b}'.format(year_ones)[::-1]
    bin_years_tens = '{0:04b}'.format(year_tens)[::-1]
    frames = []
    frames.append("1" + bin_sec_ones + "0" + bin_sec_tens + "1")
    frames.append(bin_min_ones + "0" + bin_min_tens + "01")
    frames.append(bin_hour_ones + "0" + bin_hour_tens + "001")
    frames.append(bin_day_ones + "0" + bin_day_tens + "1")
    frames.append(bin_day_hundreds + "00000001")
    frames.append(bin_years_ones + "0" + bin_years_tens + "1")
    frames.append("1000000001")
    frames.append(frames[6])
    frames.append(frames[6])
    frames.append(frames[6])
    msg = ""
    for i in range(0, frames.__len__()):

        if (test_fsm & skip_idx_frame.__contains__(i)):
            continue
        for j in range(0, frames[i].__len__()):
            if (reference_idx_list.__contains__((i * 10) + j)):
                msg = msg + reference
            elif (frames[i][j] == "1"):
                msg = msg + high
            elif (frames[i][j] == "0"):
                msg = msg + low
        msg = msg + "\n"

    f = open(dst_file , "a+")
    f.write(msg)
    f.close()
    t = t + d_time

