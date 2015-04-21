#Chart of tones and other dev notes.

-- Blue Box

key		osc1	osc2
1		700		900
2		700		1100
3		900		1100
4		700		1300
5		900		1300
6		1100	1300
7		700		1500
8		900		1500
9		1100	1500
0/10	1300	1500
**/KP	1100	1700
#/ST	1500	1700
A/ST3	700		1700
B/ST2	900		1700
C/KP2	2100	1700
D	= 2600		+ 3700 pink noise optional**

60ms, with 60ms of silence between digits. The 'KP' and 'KP2' tones are sent for 100ms.

oher src
Frequenze

---


1 -  700  2 -  700  3 -  900  A - 1100
> 900      1100      1100      1700

4 -  700  5 -  900  6 - 1100  B - 1300
  1. 00      1300      1300      1700

7 -  700  8 -  900  9 - 1100  C - 1500
  1. 00      1500      1500      1700

**- 2100  0 - 1300  # -  900  D -  700
> 2100      1500      1700      1700**

B1 - 2600  B2 - 2400
> 2400       2400



-- Red Box (Inserting Coins)
1700Hz + 2200Hz
Nickle = 1 66ms tone
Dime   = 2 66ms tones seperated by 66ms
Quarter = 5 33ms tones w/ 33ms pauses

Canadian version - same as US but just 2200 hz

UK Version
10p = 1000Hz for 200ms
50p = 1000Hz for 350 ms

-- Green Box (Subset of Blue Box, used on receiver end to control coin returns)
Green Box MF frequencies
Function	Frequencies	MF Symbol
Coin Collect	700 Hz + 1100 Hz	2
Coin Return	1100 Hz + 1700 Hz	KP
Ringback	700 Hz + 1700 Hz	11/ST3

> at least 900 milliseconds. Each should also be preceded with a 2600 Hz "wink",
> or a MF "8" symbol (900 Hz + 1500 Hz), of about 90 ms in duration, followed by about 60 ms of silence



-- Customer Dial  (Silver Box w/ A-D)
  1. 09Hz	1336Hz	1477Hz	1633Hz
697 Hz	1		2		3		A
770 Hz	4		5		6		B
852 Hz	7		8		9		C
941 Hz	