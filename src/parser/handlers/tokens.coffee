moment = require 'moment'
integer = require './int'

module.exports =
  setDividerRegex: /[xX\\*]/
  isSetRegex: /[0-9][xX\\*][0-9]/
  isSetDividerRegex: /^[xX\\*]$/
  isTimeRegex: /^(([0-9])|([0-9][0-9]))?:?(([0-9])|([0-9][0-9]))?:?(([0-9])|([0-5][0-9]))$/

  isWeightSet: (str) ->
    !!str && str.indexOf('**') is 0 && str.lastIndexOf('**') is str.length - 2

  isSet: (str) ->
    @isSetRegex.test str

  isSetDivider: (str) ->
    @isSetDividerRegex.test str

  isTimeDivider: (str) ->
    str is '@'

  isTime: (str) ->
    @isTimeRegex.test str

  isRest: (str) ->
    @getRest(str).length > 0

  getRest: (str) ->
    plusPosition = str.indexOf('+')
    justTime = str.slice(plusPosition + 1)
    isRemainderTime = @isTime justTime
    isRemainderNumber = integer.isNumber(justTime)

    if (plusPosition > -1)
      if isRemainderNumber
        return ":#{justTime}"
      else if isRemainderTime
        return justTime

    return ''

