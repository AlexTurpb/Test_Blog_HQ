class CreateComments < ActiveRecord::Migration[5.1]
  def change
  	create_table :comments do |t|
  		t.belongs_to :post, index: true
  		t.string :comment
  		t.string :author

  		t.timestamps
  	end
  end
end
