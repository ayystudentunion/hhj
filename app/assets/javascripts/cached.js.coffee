#
# Copyright 2012 Sami Hangaslammi
#
# The cached.js library is licensed under the MIT license
# http://www.opensource.org/licenses/mit-license.html
#

cache =
  json: {}
  dom:  {}
  html: {}

@cached =
  getJSON: (url, callback) ->
    future = cache.json[url]
    if future?
      future.get callback
    else
      future = new Future()
      $.ajax
        url: url
        dataType: "json"
        success: future.fulfill
        error: future.fail
        type: "get"
        cache: false
      cache.json[url] = future

  getDOM: (url, callback) ->
    future = cache.dom[url]
    if not future?
      future = new Future()
      success = (data) -> future.fulfill $(data)
      $.ajax
        url: url
        dataType: "html"
        success: success
        error: future.fail
        type: "get"
        cache: false
      cache.dom[url] = future
    future.get callback

  get: (url, callback) ->
    future = cache.html[url]
    if not future?
      future = new Future()
      $.ajax
        url: url
        dataType: "html"
        success: future.fulfill
        error: future.fail
        type: "get"
        cache: false
      cache.html[url] = future
    future.get callback

  clear: () ->
    cache =
      json: {}
      dom:  {}
      html: {}
