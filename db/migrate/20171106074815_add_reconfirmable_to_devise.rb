class AddReconfirmableToDevise < ActiveRecord::Migration[5.1]
 # Note: You can't use change, as User.update_all will fail in the down migration
 def up
  add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
end

def down
  remove_columns :users, :unconfirmed_email # Only if using reconfirmable
end
end
