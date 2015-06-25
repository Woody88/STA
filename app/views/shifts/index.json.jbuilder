json.array!(@shifts) do |shift|
  json.extract! shift, :id 
  json.start shift.start_time
  json.end shift.finish_time
  json.title shift.position
  json.id shift.id
  json.link post_shift_url(shift.id)

  
end