json.user do
  json.nickname @user.nickname
end
json.microposts do
  json.array! @microposts do |micropost|
    json.created_at micropost.created_at
    json.content micropost.content
    json.user do
      json.nickname micropost.user.nickname
    end
  end
end
