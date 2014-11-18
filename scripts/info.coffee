# Description
#   info
#
# Dependencies:
#
# Configuration:
#   HUBOT_REBOOT_MESSAGE_ROOMS : optional, room id to send reboot message
#
# Commands:
#   hubot show your info - show robo version
#
# Author:
#   ashikawa <a.shigeru@gmail.com>
#

path = require 'path'
infomation = require path.resolve __dirname, '../package.json'

module.exports = (robot) ->
  if process.env.HUBOT_REBOOT_MESSAGE_ROOMS?
    rooms = process.env.HUBOT_REBOOT_MESSAGE_ROOMS.split ','

    rooms.forEach (room, i) ->
      robot.send room: room, "Robo rebooted !!"
  else
    robot.send {}, "Robo rebooted !!"

  robot.respond /show your info/i, (msg) ->
    {name, version, author, description} = infomation

    msg.send """
    Name: #{name}
    Version: #{version}
    Author: #{author}
    #{description}
    """