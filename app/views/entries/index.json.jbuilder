json.array!(@entries) do |entry|
  json.extract! entry, :id, :title, :body, :yearmonth, :week, :day, :author_id, :publicshed, :image_url_list, :comment_id
  json.url entry_url(entry, format: :json)
end
