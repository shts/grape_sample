json.array!(@members) do |member|
  json.extract! member, :id, :name_main, :name_sub, :image_url, :birthday, :birthplace, :blood_type, :constellation, :height
  json.url member_url(member, format: :json)
end
