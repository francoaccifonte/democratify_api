# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_email  (email) UNIQUE
#  index_accounts_on_name   (name) UNIQUE
#
require 'rails_helper'

RSpec.describe(Account) do
  pending "add some examples (or delete) #{__FILE__}"
end
