# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  num        :string
#  name       :string
#  tel        :string
#  solution   :string
#  user_id    :integer          not null
#  amount     :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
