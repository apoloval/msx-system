M80 =DISK-S0
M80 =DISK-S1
M80 =DISK-S2
L80 DISK-S0/X/E/N/P:4000,DISK-S0
L80 DISK-S1/X/E/N/P:4000,DISK-S1
L80 DISK-S2/X/E/N/P:4000,DISK-S2
HEX2BIN DISK-S0.HEX DISK-S0.BIN
HEX2BIN DISK-S1.HEX DISK-S1.BIN
HEX2BIN DISK-S2.HEX DISK-S2.BIN
COPY /B DISK-S0.BIN+DISK-S1.BIN+DISK-S2.BIN+DISK-S3.BIN DISK.ROM
DEL DISK-S0.BIN
DEL DISK-S1.BIN
DEL DISK-S2.BIN
