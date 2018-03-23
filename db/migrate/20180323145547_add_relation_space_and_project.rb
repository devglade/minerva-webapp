class AddRelationSpaceAndProject < ActiveRecord::Migration[5.1]
  def self.up
    user = User.create(email: 'admin@devglade.com', password: 'password', name: '관리자', confirmed_at: Time.now)
    space = Space.create(name: 'PUBLIC', url: 'www', is_public: true, user_id: user.id)

    add_column :projects, :space_id, :bigint, null: false, default: space.id
    add_index :projects, :space_id, name: 'index_space_id'
  end

  def self.down
    remove_column :projects, :space_id
  end
end
