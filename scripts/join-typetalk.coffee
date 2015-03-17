# Description
#
# Dependencies:
#
# Configuration:
#   HUBOT_TYPETALK_CLIENT_ID
#   HUBOT_TYPETALK_CLIENT_SECRET
#
# Commands:
#   hubot join us - accept all invites
#
# Author:
#   ashikawa <a.shigeru@gmail.com>
#

deferred = require 'deferred'
request  = require 'request'

requestDeferred = (data) ->
  dfd = deferred()

  data.json = true

  request.post data, (error, response, body) ->
    dfd.resolve body

    return dfd.promise()

module.exports = (robot) ->
  robot.respond /join[ ]*us.*/i, (msg) ->
    requestDeferred {
      url: 'https://typetalk.in/oauth2/access_token',
      method: 'POST',
      form : {
        'client_id': process.env.HUBOT_TYPETALK_CLIENT_ID,
        'client_secret': process.env.HUBOT_TYPETALK_CLIENT_SECRET,
        'grant_type': 'client_credentials',
        'scope': 'topic.post,topic.read'
      }
    }
    .then (body) ->
      accessToken = body.access_token

      return requestDeferred {
        url: 'https://typetalk.in/api/v1/notifications',
        method: 'GET',
        headers: {
          'Authorization': 'Bearer ' + accessToken
        }
    }
    .done (body) ->
      body.invites.topics.forEach (invite,i) ->
        requestDeferred {
          url: "https://typetalk.in/api/v1" +
            "/topics/#{invite.topic.id}/members/invite/#{invite.id}/accept",
          method: 'POST',
          headers: {
            'Authorization': 'Bearer ' + accessToken
          }
        }
        .done (body) ->
          msg.send "Joined! [#{body.invite.topic.name}]" +
            "(https://typetalk.in/topics/#{body.invite.topic.id})"
