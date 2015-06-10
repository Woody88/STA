# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#calendar').fullCalendar
    editable: true,
    displayEventEnd: true,
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,

    events: "/shifts/index.json",

    timeFormat: 'H(:mm)',
    dragOpacity: "0.5"

    eventDataTransform: (eventData) -> 
      s = moment(eventData.start).zone(eventData.start).format("HH:mm");
      if s == "00:00"
        eventData.start = new Date(86400000);
        eventData.end = new Date(86400000);
      eventData
      
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);


updateEvent = (the_event) ->
  $.update "/events/" + the_event.id,
    event:
      title: the_event.title,
      starts_at: "" + the_event.start,
      ends_at: "" + the_event.end,
      description: the_event.description