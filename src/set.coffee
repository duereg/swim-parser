Interval = require('./interval')
IntervalSet = require('./intervalSet')
actions = require('./actions')

class Set
  constructor: (options) ->
    {@name, @intervals} = options if options?
    @intervals ?= []
    @name ?= ''

  toString: ->
    output = ''
    output += @name + '\n' if @name.length
    output += @intervals.map((interval) -> interval.toString()).join('\n')
    output

  toJSON: ->
    {@name, intervals: @intervals.map (interval) -> interval.toJSON()}

  addInterval: (intervalToAdd) ->
    throw new Error('Invalid interval given')  if intervalToAdd is null
    intervalToAdd = new Interval()  unless intervalToAdd?
    @intervals.push intervalToAdd
    intervalToAdd

  current: ->
    currentInterval = null
    intervalLength = @intervals.length
    if intervalLength > 0
      currentInterval = @intervals[intervalLength - 1]
    else
      currentInterval = @addInterval()
    currentInterval

  changeToMulti: ->
    numIntervals = @current().distance
    #remove single interval
    @intervals.pop()
    #replace with interval set
    @addInterval new IntervalSet(numIntervals)

  setRest: (rest) ->
    @current().rest = rest

  setDistance: (distance) ->
    @current().distance = distance

  setTime: (time) ->
    @current().time = time

  setType: (type) ->
    @current().type = type

  totalDistance: ->
    actions.sum @intervals, 'distance'

  totalTime: ->
    actions.sum @intervals, 'time'

  totalIntervals: ->
    total = 0

    for interval in @intervals
      if interval?.intervals
        total += interval.intervals.length
      else
        total += 1

    total

module.exports = Set
