http = require('http')
ws = require('nodejs-websocket')
fs = require('fs')
pg = require("pg").native
query = require('pg-query')
merge = require('merge')

broadcast = (str) ->
  server.connections.forEach (connection) ->
    connection.sendText str
    return
  return

pgConfig =
  user: 'aveiro'
  password: 'aveiro'
  database: 'real-time-test'
  host: 'localhost'
  poolSize: 15




http.createServer((req, res) ->
  fs.createReadStream('index.html').pipe res
  return
).listen 8090
server = ws.createServer((connection) ->
  pg.defaults = merge(pg.defaults, pgConfig)
  long_pooling_dbclient = new pg.Client(pg.defaults)
  long_pooling_dbclient.connect()
  long_pooling_dbclient.query "LISTEN \"" + "activity_feed" + "\""
  long_pooling_dbclient.on "notification", (data) ->
    try
      feed = JSON.parse(data.payload)
      console.log "notification received!"
      console.log feed
      broadcast data.payload
    catch e
      console.error e
      console.error data.payload
    return
    long_pooling_dbclient.on 'error', (data)->
      console.error data
  connection.on 'text', (str) ->
    console.log str
    promise = query 'INSERT INTO activity_feeds (title) VALUES ($1) RETURNING id', [str]
    promise.spread ->
      console.info "New feed saved to db!"
    , ->
      console.error("error running query", err) if err

    return
  connection.on 'close', ->
    return
  return
)
server.listen 8091
console.log "Websocket server started on 8091"