class AddDeletedAtToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :deleted_at, :datetime, default: nil
    add_index :comments, :deleted_at

    # 索引是給電腦看的
  end
end
