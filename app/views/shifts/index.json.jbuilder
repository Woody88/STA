json.array!(@shifts) do |shift|
  json.extract! shift
  json.start shift.start_time
  json.end shift.finish_time
  json.title shift.position
  json.id shift.id
  
end