# Description:
#   Find the build status of an open-source project on Travis
#   Can also notify about builds, just enable the webhook notification on
#   travis http://about.travis-ci.org/docs/user/build-configuration/
#       -> 'Webhook notification'
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot travis me <user>/<repo> - Returns the build status
#
# URLS:
#   POST /hubot/travis?room=<room>[&type=<type]
#
# Author:
#   sferik
#   nesQuick
#   sergeylukin

url = require('url')
querystring = require('querystring')

module.exports = (robot) ->

  robot.respond /travis me (.*)/i, (msg) ->
    project = escape(msg.match[1])
    msg.http("https://api.travis-ci.org/repos/#{project}")
      .get() (err, res, body) ->
        response = JSON.parse(body)
        if response.last_build_status == 0
          msg.send "Build status for #{project}: Passing"
        else if response.last_build_status == 1
          msg.send "Build status for #{project}: Failing"
        else
          msg.send "Build status for #{project}: Unknown"

  robot.router.post "/hubot/travis", (req, res) ->
    query = querystring.parse url.parse(req.url).query

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type

    try
      payload = JSON.parse req.body.payload

      {status_message, build_url, repository,
        branch, author_name, compare_url} = payload

      robot.send user, "#{status_message.toUpperCase()} " +
        "build ( #{build_url} ) on #{repository.name}:#{branch} " +
        "by #{author_name} with commit ( #{compare_url} )"

    catch error
      console.log "travis hook error: #{error}. Payload: #{req.body.payload}"

    #some client have problems with and empty response,
    # sending that response ion sync makes debugging easier
    res.end JSON.stringify {
      send: true
    }
