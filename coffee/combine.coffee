
http =
  get: (url, callback) ->
    req = new XMLHttpRequest
    req.open "GET", url
    req.send()
    req.onload = ->
      callback (JSON.parse req.responseText)

getIssue = (number) ->
  "https://api.github.com/repos/seajs/seajs/issues/#{number}"
  # "mock/#{number}"

issueIds = [240, 242, 258, 259, 260, 262, 538]

q = (query) ->
  document.querySelector query

define (require) ->
  hljs = require "hljs"
  Ractive = require "Ractive"
  c2m = require "c2m"
  cirru = require "cirru"
  marked = require "marked"

  cirru.parse.compact = yes
  marked.setOptions
    highlight: (code, lang) ->
      if hljs?
        hljs.highlight(lang, code).value
      else
        code
    gfm: yes
    breaks: yes

  makeTmpl = (file) ->
    c2m.render cirru.parse file

  tableTmpl = makeTmpl require "text!table"
  issueTmpl = makeTmpl require "text!issue"

  table = new Ractive
    el: q '#content-table'
    template: tableTmpl
    data:
      list: []

  issueIds.map (id) ->
    http.get (getIssue id), (data) ->
      table.data.list.push data

  issue = new Ractive
    el: q '#article'
    template: issueTmpl
    data: {}

  cache = {}

  table.on
    load: (event) ->
      data = event.context
      issue.set "html_url", data.html_url
      issue.set "title", data.title
      issue.set "updated_at", data.updated_at
      issue.set "user.login", data.user.login
      issue.set "user.url", data.user.url
      if cache[data.title]?
        issue.set "body", cache[data.title]
      else
        html = marked data.body
        cache[data.title] = html
        issue.set "body", html
