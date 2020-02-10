# == Schema Information
#
# Table name: directors
#
#  id         :integer          not null, primary key
#  name       :string
#  dob        :date
#  bio        :text
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Director < ApplicationRecord
end
