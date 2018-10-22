# == Schema Information
#
# Table name: recipis
#
#  id                      :bigint(8)        not null, primary key
#  ingredients             :string           is an Array
#  name                    :string
#  preparation_description :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  owner_id                :bigint(8)
#
# Indexes
#
#  index_recipis_on_name      (name)
#  index_recipis_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#

class Recipi < ApplicationRecord
  belongs_to :owner
end
