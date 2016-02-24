json.array!(@entries) do |entry|
  json.id = entry.id
  json.title = entry.title
  json.body = entry.body

  json.yearmonth = entry.yearmonth
  json.day = entry.day
  json.week = entry.week
  json.published = entry.published

  json.member_id = entry.member.id
  json.member_name_main = entry.member.name_main
  json.member_image_url = entry.member.image_url
end
