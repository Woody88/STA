ready = ->

  ## Retrieve current posts ##
  ajax1 =     
    $.ajax
      async: true
      type: 'GET'
      url: '/posts.json'
      success: (data) ->

  $.when(ajax1, Posts).done (a1) ->
    posts = a1[0]
    i = 0
    while i < posts.length
      if posts[i].profile_id == EmpId
        posts[i].isUser = true
        console.log("equal")
      else
        posts[i].isUser = false
        console.log("not equal")

       

      Posts.push('list', posts[i])
      i++

  ## Sets Posts Template ##
  Posts = new Ractive
    el: "#templateWrapper"
    template: '#template'
    data: {list:[], EmpId: EmpId}
    
  
  
  Posts.on
    ## Hand new posts ##
    post: ( event ) ->
      event.original.preventDefault()
      console.log(this.get('content'))

      ## reset the form ##
      send(this.get('content'))
      this.set({content: '' })

    remove: ( event, index ) ->
      this.get('list').splice( index, 1 )
      console.log(index)




    
    


  ## Websocket functioning ##

  dispatcher = new WebSocketRails($('#posting').data('uri'), true)
  
  dispatcher.on_open = (data) ->
    console.log('Connection has been established: ', data);

  channel = dispatcher.subscribe 'posts'

  channel.bind 'new_post', (message) ->
    console.log(message)
    message.created_at = "less than a minute"
    Posts.unshift('list', message).slideUp("slow")

  send = (message) ->
    dispatcher.trigger 'posting', message

$(document).ready(ready)
$(document).on('page:load', ready)