#http://cjihrig.com/blog/server-sent-events-in-node-js/
http = require('http')
fs = require('fs')
http.createServer((req, res) ->
  index = './index.html'
  fileName = undefined
  interval = undefined
  if req.url == '/'
    fileName = index
  else
    fileName = '.' + req.url
  if fileName == './stream'
    res.writeHead 200,
      'Content-Type': 'text/event-stream'
      'Cache-Control': 'no-cache'
      'Connection': 'keep-alive'
    res.write 'retry: 10000\n'
    res.write 'event: connecttime\n'
    res.write 'data: ' + new Date + '\n\n'
    res.write 'data: ' + new Date + '\n\n'
    interval = setInterval((->
      res.write 'data: ' + new Date + '\n\n'
      return
    ), 1000)
    req.connection.addListener 'close', (->
      clearInterval interval
      return
    ), false
  else if fileName == index
    fs.exists fileName, (exists) ->
      if exists
        fs.readFile fileName, (error, content) ->
          if error
            res.writeHead 500
            res.end()
          else
            res.writeHead 200, 'Content-Type': 'text/html'
            res.end content, 'utf-8'
          return
      else
        res.writeHead 404
        res.end()
      return
  else
    res.writeHead 404
    res.end()
  return
).listen 3999, 'localhost'
console.log 'Server running at http://127.0.0.1:3999/'
