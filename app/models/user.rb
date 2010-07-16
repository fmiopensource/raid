class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field "email"
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
