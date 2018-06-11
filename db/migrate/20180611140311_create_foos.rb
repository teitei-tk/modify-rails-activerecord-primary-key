class CreateFoos < ActiveRecord::Migration[5.2]
  def change
    create_table :foos, id: :integer do |t|

      t.timestamps
    end
  end
end
