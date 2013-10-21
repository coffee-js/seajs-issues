
! $ h3 $ = {{title}}
small
  #html_url
    a (:href {{html_url}}) $ = Link
  = Last updated
  #user
    = by
    a (:href {{url}}) $ = @{{login}}
  ^user
    = by jiyinyiyong
  #updated_at
    = at {{updated_at}}
div.body
  = {{{body}}}