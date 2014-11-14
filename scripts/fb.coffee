# Description:
#   Check the site faebook sdk version
#
# Dependencies:
# Configuration:
#   None
#
# Commands:
#   hubot chkfb <url> - check url

module.exports = (robot) ->
  robot.respond /chkfb (.*)?$/i, (msg) ->
    url = msg.match[1]

    msg.http(url)
      .get() (err, res, body) ->
        text = 'Facebook SDK Notfound'

        if body.match /connect.facebook.net\/([^\/]+\/)?all\.js/
          text = "old 'all.js' found!! Please replace code";

        if body.match /connect.facebook.net\/([^\/]+\/)?sdk\.js/
          text = "new 'sdk.js' found. nothing to do.";

        msg.send text
