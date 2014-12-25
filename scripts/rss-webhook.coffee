# Description
#   rss webhook
# Dependencies:
#   None
# Configuration:
#   None
# Commands:
#   None
# Author:
#   ashikawa <a.shigeru@gmail.com>
#

module.exports = (robot) ->
  robot.router.post "/hubot/rss-webhook/:room", (req, res) ->
    envelope = room: req.params.room

    {title, description, pubDate, content, link, raw, guid} =
      JSON.parse req.body

    robot.send envelope, """
    New item in feed.
    #{title} ( #{link} )
    """

    res.end "OK"
