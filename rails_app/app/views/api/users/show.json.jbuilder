json.user do
  json.id @user.id
  json.nickname @user.nickname
  json.followed current_user.following?(@user)
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
