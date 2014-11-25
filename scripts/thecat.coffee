# Description:
#   cat me is the most important thing in your life (ΦωΦ)
#   Interacts with The Cat API. (http://thecatapi.com/)
#
# Dependencies:
#   "cheerio": "~0.13.1"
#
# Configuration:
#   None
#
# Commands:
#   hubot cat me <category> - Receive a cat
#   hubot cat bomb N <category> - get N cats
#   hubot show me cat's categories - show cat's active categories.

$ = require 'cheerio'
BASE_URL = "http://thecatapi.com/api"

module.exports = (robot) ->
  robot.respond /cats? me( (.*))?/i, (msg) ->
    url = "#{BASE_URL}/images/get?format=xml"

    if msg.match[2]
      url = "#{url}&category=#{msg.match[2]}"

    msg.http(url)
      .get() (err, res, body) ->
        image = $(body).find('url')
        text = image.text()

        if !!text
          msg.send text
        else
          msg.send "No image found. " +
              "https://servicechampions.com/wp-content/uploads/404cat.jpg"

  robot.respond /cats? bomb( (\d+))?( (.*))?/i, (msg) ->
    count = msg.match[2] or 5
    url = "#{BASE_URL}/images/get?format=xml&results_per_page=#{count}"

    if msg.match[4]
      url = "#{url}&category=#{msg.match[4]}"

    msg.http(url)
      .get() (err, res, body) ->
        images = $(body).find('image')

        if images.length
          msg.send $(image).find('url').text() for image in images
        else
          msg.send "No image found. " +
            "https://servicechampions.com/wp-content/uploads/404cat.jpg"

  robot.respond /show me cat's categories/i, (msg) ->
    msg.http(BASE_URL + "/categories/list")
      .get() (err, res, body) ->
        categories = $(body).find('category')

        message = []

        for category in categories
          message.push $(category).find('name').text()

        msg.send "Cat's categories: #{message.join(', ')}"
