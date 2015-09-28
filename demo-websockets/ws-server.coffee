http = require('http')
ws = require('nodejs-websocket')
fs = require('fs')

broadcast = (str) ->
  server.connections.forEach (connection) ->
    connection.sendText str
    return
  return

http.createServer((req, res) ->
  fs.createReadStream('index.html').pipe res
  return
).listen 8080
server = ws.createServer((connection) ->
  connection.nickname = null
  connection.on 'text', (str) ->
    if connection.nickname == null
      connection.nickname = str
      broadcast str + ' entered'
    else
      broadcast '[' + connection.nickname + '] ' + str
    return
  connection.on 'close', ->
    broadcast connection.nickname + ' left'
    return
  return
)
server.listen 8081
console.log "Websocket server started on 8081"