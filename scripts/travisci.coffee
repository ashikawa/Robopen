# Description
#   travisci webhook
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

module.exports = (robot) ->
  robot.router.post "/travisci/:room", (req, res) ->
    envelope = room: req.params.room
    {payload} = req.body
    {status_message, build_url, message, number, repository} = JSON.parse payload

    robot.send envelope, """
    Build##{ number } for #{ repository.owner_name }/#{ repository.name } #{ if status_message is 'Pending' then 'started.' else "finished. (#{status_message})" }
    > #{message}
    #{build_url}
    """

    res.end "OK"