Factory.define :user do |u|
  u.email "test@example.com"
  u.first_name "Mike"
  u.last_name "Trpcic"
  u.password "password"
  u.password_confirmation "password"
end