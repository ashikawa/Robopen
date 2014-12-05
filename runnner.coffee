opts = require 'opts'
TextMessage = require("hubot/src/message").TextMessage

opts.parse [
    'short': 's'
    'long': 'script'
    'description': 'load script'
    'value': true
    'required': true
  ,
    'short': 'm'
    'long': 'message'
    'description': 'input message'
    'value': true
    'required': true
]

Robot = require 'hubot/src/robot'
robot = new Robot null, 'mock-adapter', false, 'hubot'

script = opts.get 'script'

user = null

robot.adapter.on 'connected', ->
  require(script) robot

robot.run()

robot.adapter.on 'send', (envelope, strings) ->
  strings.forEach (item, i) ->
    console.log "Hubot: #{item}"
  robot.shutdown()

message = opts.get 'message'

console.log "You: #{message}"
robot.adapter.receive new TextMessage {}, message
