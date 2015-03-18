# Description
#   uptimerobot webhook
#
# Dependencies:
#   None
# Configuration:
#   None
# Commands:
#   None
# Author:
#   ashikawa <a.shigeru@gmail.com>
#

url = require 'url'

module.exports = (robot) ->
  robot.router.get "/uptimerobot/:room", (req, res) ->
    envelope = room: req.params.room
    {monitorID, monitorURL, monitorFriendlyName, alertType, alertDetails} =
    # monitorAlertContacts
        url.parse(req.url, true).query

    unless monitorID?
      res.end "OK"
      return

    status = switch alertType
      when '0' then 'paused'
      when '1' then 'not checked yet'
      when '2' then 'up'
      when '8' then 'seems down'
      when '9' then 'down'

    robot.send envelope, """
    Monitor is #{status}
    #{monitorFriendlyName} (#{monitorURL})
    """

    res.end "OK"
