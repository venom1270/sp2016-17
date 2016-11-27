# sudo pip install git+https://github.com/dpallot/simple-websocket-server.git

from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket
import time
import random
import threading
import json

clients = []

class SimpleEcho(WebSocket):

    def handleMessage(self):
        # echo message back to client
        #self.sendMessage("... and I respond to you "+self.data+" as well! -Matevz")
        print (self.address, self.data)
       
        msg = json.loads(self.data)
        print (self.address, msg["requestType"])
        if msg["requestType"] == 'postComment':
            print("OKComment")
            self.sendMessage("OKComment")
        elif msg["requestType"] == 'postReply':
            print (self.address, 'OKReply')
            self.sendMessage("OKReply")
        elif msg["requestType"] == 'vote':
            print (self.address, 'OKVote')
            self.sendMessage("OKVote")
		
		

    def handleConnected(self):
        print(self.address, 'connected')
        clients.append(self)

    def handleClose(self):
        print(self.address, 'closed')
        clients.remove(self)


host = '127.0.0.1'
port = 1234
server = SimpleWebSocketServer(host, port, SimpleEcho)
print("Listening on "+host+":"+str(port))
server.serveforever()