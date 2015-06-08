colors = require 'colors'

class OutputMediator

  separator: Array(80).join('-')

  constructor: (@sender) ->

  print: (alertion, args...) ->
    args.unshift @decorateAlertion(alertion)
    args.unshift @decoratedSender(@sender)
    console.log(args...)
    this

  ok: (args...) ->
    args.unshift('okay')
    @print(args...)

  err: (args...) ->
    args.unshift('err!')
    @print(args...)

  warn: (args...) ->
    args.unshift('warn')
    @print(args...)

  info: (args...) ->
    args.unshift('info')
    @print(args...)

  sep: ->
    console.log(@separator)
    this

  n: ->
    console.log("\n")
    this

  decorateAlertion: (alertion) ->
    result = alertion.toUpperCase()
    switch result
      when 'OKAY'
        result.bgGreen.black
      when 'ERR!'
        result.bgRed.black
      when 'WARN'
        result.bgYellow.black
      when 'INFO'
        result.bgWhite.black
      else
        result

  decoratedSender: (sender) ->
    sender.bgBlack.white

  @create: (sender) ->
    new this(sender)

module.exports = OutputMediator