colors = require 'colors'
printf = require 'printf'

class OutputMediator

  separator: Array(80).join '-'

  constructor: (sender) ->
    @sender = sender

  output: (sender, alertion, args) ->
    return unless args.length
    message = printf args...
    args = []
    args.push @decoratedSender sender if sender
    args.push @decorateAlertion alertion if alertion
    args.push message
    console.log args...

  err: (args...) ->
    @output @sender, 'err', args

  ok: (args...) ->
    @output @sender, 'ok', args

  warn: (args...) ->
    @output @sender, 'warn', args

  sep: ->
    console.log @separator

  decorateAlertion: (alertion) ->
    alertion = alertion.toUpperCase()
    switch alertion
      when 'OK'
        alertion.bgGreen.black
      when 'ERR'
        alertion.bgRed.black
      when 'WARN'
        alertion.bgYellow.black
      else
        alertion

  decoratedSender: (sender) ->
    sender.magenta

  @channelFor: (->
    cache = {}
    (sender) ->
      cache[sender] || (cache[sender] = new @(sender))
  )()

module.exports = OutputMediator