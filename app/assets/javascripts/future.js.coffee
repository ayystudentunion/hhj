#
# Copyright 2012 Sami Hangaslammi
#
# The future.js library is licensed under the MIT license
# http://www.opensource.org/licenses/mit-license.html
#

WAITING = 0
SUCCESS = 1
ERROR   = -1

class Future
  constructor: () ->
    @listeners = []
    @result    = null
    @status    = WAITING

  callback: (error, value) =>
    if error?
      @fail error
    else
      @fulfill value

  fulfill: (value) =>
    throw "Diverging future" if @status != WAITING
    @result = value
    @status = SUCCESS
    callback null, value for callback in @listeners
    @listeners = []

  fail: (error) =>
    throw "Diverging future" if @status != WAITING
    @result = error
    @status = ERROR
    callback error, null for callback in @listeners
    @listeners = []

  get: (callback) -> switch @status
    when WAITING then @listeners.push callback
    when SUCCESS then callback null, @result
    when ERROR   then callback @result, null

@Future = Future
