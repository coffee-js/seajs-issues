

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

marked.setOptions
  gfm: yes
  breaks: yes
  highlight: (code, lang) ->
    hljs.highlightAuto(code).value

$table = q '#content-table'
$content = q '#article'

issueIds.map (id) ->
  http.get (getIssue id), (data) ->
    $title = document.createElement('p')
    $title.innerText = data.title
    $title.onclick = ->
      q('.pointing')?.removeAttribute 'class'
      @setAttribute 'class', 'pointing'
      
      template = """
        <small>
          <a href="#{data.html_url}" target="_blank">
            Issue on GitHub
          </a>
          last updated by <a href="#{data.user.url}">#{data.user.login}</a>
          at #{data.updated_at}
        </small>
        <div class="body">
          #{marked data.body}
        </div>
        """
      article.innerHTML = template

    $table.appendChild $title
