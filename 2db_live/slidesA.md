<!SLIDE subsection sse>

# Live database notifications
* Standard in NoSQL DBs (eg. Redis, MongoDB etc.) PUB/SUB pattern
* supported by PostgreSQL LISTEN/NOTIFY
* idea: TRIGGER on table INSERT/UPDATE the NOTIFY event, that gets transferred through SSE/websockets

<!SLIDE small transition=fade>

# create DB

    @@@sql
    CREATE TABLE activity_feeds (
       id INT PRIMARY KEY     NOT NULL,
       title        CHAR(50),
       performed_at        TIMESTAMP DEFAULT now()
     );
     
<!SLIDE small transition=fade>

# function to fire NOTIFY event

    @@@sql
      CREATE OR REPLACE FUNCTION notify_activity_insert() 
      RETURNS trigger AS 
      $$
      DECLARE
      BEGIN
        PERFORM pg_notify('activity_feed', row_to_json(NEW)::TEXT);
        RETURN new;
      END;
      $$ LANGUAGE plpgsql;
      
# create trigger on insert

    @@@sql
    CREATE TRIGGER activity_feed_trigger 
    AFTER INSERT ON activity_feeds 
    FOR EACH ROW EXECUTE PROCEDURE notify_activity_insert();
    
<!SLIDE small transition=fade>

# LISTEN to pg notifications (node.js)

    @@@javascript
    dbclient = new pg.Client(pg.defaults)
    dbclient.connect()
    dbclient.query "LISTEN \"" + "activity_feed" + "\""
    dbclient.on "notification", (data) ->
      console.log data
    
[DEMO](http://localhost:8090)

<!SLIDE transition=fade>
# Further reading

* [postgres docs](http://www.postgresql.org/docs/9.4/static/sql-notify.html)
* [Socket.IO](http://socket.io/)
* [jQuery SSE](https://github.com/byjg/jquery-sse)

## Thanks, questions?