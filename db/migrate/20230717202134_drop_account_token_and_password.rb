class DropAccountTokenAndPassword < ActiveRecord::Migration[7.0]
  # rubocop:disable Rails/BulkChangeTable
  def change
    remove_column :accounts, :token, :string
    remove_column :accounts, :password_digest, :string
  end
  # rubocop:enable Rails/BulkChangeTable
end
