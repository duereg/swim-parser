{expect} = require "./spec-helper"
IntervalSet = require "../lib/intervalSet"
Interval = require "../lib/interval"
moment = require 'moment'
_ = require 'underscore'

describe "IntervalSet", ->
  {set} = {}

  describe "Created a full set", ->
    beforeEach ->
      set = new IntervalSet(4)

    it "creates a populated array", ->
      expect(set.intervals.length).to.eq(4)

    it "::isEmpty returns false", ->
      expect(set.isEmpty()).to.be.false

    describe 'setting distance', ->
      beforeEach ->
        set.distance = 100

      it 'sets the distance on the underlying intervals', ->
        expect(_(set.intervals).all((interval) -> interval.distance is 100)).to.be.true

  describe "Creating an empty set", ->
    beforeEach ->
      set = new IntervalSet()

    it "creates an array of empty intervals", ->
      expect(set.intervals).to.eql []

    it "outputs an empty string", ->
      expect(set.toString()).to.eq ""

    it "::isEmpty returns true", ->
      expect(set.isEmpty()).to.be.true

    describe "::current", ->
      {interval} = {}

      beforeEach ->
        interval = set.current()

      it 'creates a new interval if called when empty', ->
        expect(set.intervals.length).to.eq 1

      it 'creates a valid interval', ->
        expect(interval).to.be.ok

    describe "::addInterval", ->
      it "calling with null throws", ->
        expect(() -> set.addInterval(null)).to.throw "Invalid interval given"

      it "calling with no params creates an empty interval", ->
        expect(set.addInterval()).to.be.ok

    describe "with multiple intervals", ->
      beforeEach ->
        set.addInterval new Interval {distance: 100, type: 'huho', time: moment.duration('00:01:30')}
        set.addInterval new Interval {distance: 100, type: 'huho', time: moment.duration('00:01:30')}
        set.addInterval new Interval {distance: 100, type: 'huho', time: moment.duration('00:01:30')}

      describe "::toString", ->
        it 'displays correct set notation for all intervals', ->
          expect(set.toString()).to.eq "3x100 huho @ 1:30"

      describe "distance", ->
        it 'sums the distances correctly', ->
          expect(set.distance).to.eq 300

      describe "time", ->
        {time} = {}

        beforeEach ->
          time = moment.duration(set.time)

        it 'sums the times correctly', ->
          expect(time.minutes()).to.eq 4
          expect(time.seconds()).to.eq 30