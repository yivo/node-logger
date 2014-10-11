colors = require 'colors'
printf = require 'printf'

class OutputMediator

  separatorString: Array(80).join '-'

  output: (alertion, args) ->
    return unless args.length
    message = printf args...
    args = []
    args.push @decoratedSender()
    alertion = alertion[0].toUpperCase() + alertion.slice(1)
    args.push @['decorated' + alertion]()
    args.push message
    console.log args...

  err: (args...) ->
    @output 'err', args

  ok: (args...) ->
    @output 'ok', args

  warn: (args...) ->
    @output 'warn', args

  sep: ->
    console.log @separatorString

  decoratedSender: ->
    if @__from then String(@__from).magenta else 'global'

  decoratedOk: ->
    'OK'.bgGreen.black

  decoratedErr: ->
    'ERR'.bgRed.black

  decoratedWarn: ->
    'WARN'.bgYellow.black

  global: ->
    @__from = null
    @

  from: (sender) ->
    @__from = sender
    @

module.exports = new OutputMediator()