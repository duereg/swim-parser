var moment, _;

moment = require('moment');

_ = require('underscore');

module.exports = function(time) {
  var format;
  format = '';
  if (time == null) {
    throw new Error("Invalid time given");
  }
  if (!_(time.hours).isFunction() && (_(time).isObject() || _(time).isNumber())) {
    time = moment.duration(time);
  }
  if (time.hours()) {
    format += time.hours() + ':';
  }
  if (time.minutes() === 0 && time.hours()) {
    format += '00:';
  } else {
    format += time.minutes() + ':';
  }
  if (time.seconds() === 0) {
    format += '00';
  } else {
    format += time.seconds();
  }
  return format;
};