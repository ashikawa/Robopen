# Description
#   info
#
# Dependencies:
#
# Configuration:
#   BOOT_MESSAGE_TO : optional, room id to send reboot message
#
# Commands:
#   hubot show your info - show robo version
#
# Author:
#   ashikawa <a.shigeru@gmail.com>
#

path = require 'path'
infomation = require path.resolve(__dirname, '../package.json')

module.exports = (robot) ->

  if process.env.BOOT_MESSAGE_TO?
    robot.send room: process.env.BOOT_MESSAGE_TO, "robo rebooted !!"

  robot.respond /show your info/i, (msg) ->
    {name, version, author, description} = infomation

    msg.send """
    Name: #{name}
    Version: #{version}
    Author: #{author}
    #{description}
    """