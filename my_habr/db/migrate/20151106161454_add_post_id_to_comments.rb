class AddPostIdToComments < ActiveRecord::Migration
  def change
    # Вариант 1:
    # add_column :comments, :post_id, :integer

    # Вариант 2:
    # change_table :comments do |t|
    #   t.integer :post_id
    # end

    # Вариант 3:
    # add_reference :comments, :post. index: true

    # Вариант 4:
      add_belongs_to :comments, :post
  end
end
