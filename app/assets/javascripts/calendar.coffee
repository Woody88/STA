# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  DateConvert = (d) ->
    time = Date.parse(d.toString().replace(/T|Z/g, ' '))
    time = moment(new Date(time)).format("HH:mm") 

    return time

  $('#calendar').fullCalendar
    
    # Calendar View 
    editable: true,
    displayEventEnd: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    aspectRatio: 2
    slotMinutes: 30,
    eventLimit: true,
    timeFormat: 'HH:mm'
    dragOpacity: "0.5" 

    # Events 
    events: "/shifts.json"


    eventRender: (event, element, startParam) -> 
        $('.fc-container').css('font-size', '1.8em !important')
        posted_shift_path = "post_shift/" + event.id.toString()

        element.popover
            title: event.title,
            placement: 'bottom',
            html: true,
            animation: true,
            content: 'Start: ' + event.start.format("HH:mm") + '<br />End: ' +  event.id +  event.end.format("HH:mm") + '<br />Description: ' + event.description + '<br /> <a id="post_shift" href= "post_shift/"class= "post" role ="button">Post Shift</a>
            <a href="google.com">Trade With Collegue</a>'
            template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title" ></h3><div class="popover-content">hello</div></div> ' 
            container: 'body'

     
    eventDataTransform: (eventData, startParam) ->
      s = DateConvert(eventData.start)
      f = DateConvert(eventData.end)

      if s == "00:00"
        eventData.start = new Date(86400000);
        eventData.end = new Date(86400000);

      eventData
      
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);

    eventClick: (calEvent, jsEvent, view) -> 
        $('.post').on "click", -> 
          $(this).prop('href', "/post_shift/" + calEvent.id)


updateEvent = (the_event) ->
  $.update "/events/" + the_event.id,
    event:
      title: the_event.title,
      starts_at: "" + the_event.start,
      ends_at: "" + the_event.end,
      description: the_event.description


$(document).ready(ready)
$(document).on('page:load', ready)