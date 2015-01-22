# Description:
#   Send notifications to the Dev Rooms, just enable
#   the webhook notification on magnum
#   https://github.com/magnumci/documentation/blob/master/webhooks.md
#   -> 'Webhook notification'
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/magnum-ci
#     - process the standard payload parameter

url = require 'url'

rooms = []
if process.env.HUBOT_DEV_ROOMS?
  rooms = process.env.HUBOT_DEV_ROOMS.split ','

module.exports = (robot) ->
  robot.router.post '/hubot/magnum-ci', (req, res) ->
    rooms.forEach (room, i) ->
      try
        payload = JSON.parse req.body.payload
        user = room: room
        user.type = payload.type if payload.type
        robot.send user, """
        #{payload.title}
        #{payload.build_url}
        """
      catch error
        console.log "magnum-ci hook error: #{error}. " +
          "Payload: #{req.body.payload}"

      #some client have problems with and empty response,
      # sending that response ion sync makes debugging easier
      res.end JSON.stringify {
        send: true
      }
