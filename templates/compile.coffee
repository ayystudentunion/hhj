
exec = require('child_process').exec

exec 'jade --out web jade', (err) -> console.log "jade: #{err.message}" if err?
exec 'stylus --out web/css stylus', (err) -> console.log "stylus: #{err.message}" if err?
exec 'coffee -c --output web/js coffee', (err) -> console.log "coffee: #{err.message}" if err?
setTimeout(null, 24*60*60000)
