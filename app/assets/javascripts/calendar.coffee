# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("input[name=commit]").submit (event), ->
    event.preventDefault()

  refresh_posts = ->
    $.ajax
      type: 'GET'
      url: 'posts'
      success: (data) ->
      complete: ->
        # Schedule the next request when the current one's complete
        setTimeout refresh_posts, 60000

  DateConvert = (d) ->
    time = moment(d).utcOffset(d).format("HH:mm")

    return time

  $('.user_calendar').fullCalendar
    
    # Calendar View 
    editable: true,
    displayEventEnd: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 400,
    aspectRatio: 1
    slotMinutes: 30,
    eventLimit: true,
    timeFormat: 'HH:mm'
    dragOpacity: "0.5" 
    

    # Events 
    events: "/shifts.json"


    eventRender: (event, element, view) -> 


        $('.fc-container').css('font-size', '1.8em !important')
        posted_shift_path = "post_shift/" + event.id.toString()

        if (event.status == "posted")
          element.css('background-color', 'red')
         

        element.popover
            title: event.title,
            placement: 'bottom',
            html: true,
            animation: true,
            content: 'Start: ' + event.start.format("HH:mm") + '<br />End: ' + event.end.format("HH:mm") + '<br />Description: ' + event.description + '<br /> <a id="post_shift" href= "post_shift/" class= "post" role ="button">Post Shift</a> |
            <a href="trade_with_collegue/" class="collegue_trade">Trade With Collegue</a>'
            template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title" ></h3><div class="popover-content">hello</div></div> ' 
            container: 'body'

     
    eventDataTransform: (eventData, startParam) ->
      s = DateConvert(eventData.start)
      f = DateConvert(eventData.end)
      
      eventData
      
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);

    eventClick: (calEvent, jsEvent, view) -> 
        $('.post').on "click", -> 
          $(this).prop('href', "/post_shift/" + calEvent.id)

        $('.collegue_trade').on "click", ->
          $(this).prop 'href', 'trade_with_collegue/' + calEvent.id


    updateEvent = (the_event) ->
      $.update "/events/" + the_event.id,
        event:
          title: the_event.title,
          starts_at: "" + the_event.start,
          ends_at: "" + the_event.end,
          description: the_event.description

  refresh_posts()


$(document).ready(ready)
$(document).on('page:load', ready)