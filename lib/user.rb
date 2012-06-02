class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email

  def self.id_for(data)
    find_or_create_by_email(data["email"],
                            {first_name: data["first_name"],
                             last_name: data["last_name"]}).id
  end
end
