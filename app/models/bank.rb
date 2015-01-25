class Bank < ActiveRecord::Base
  has_many :invoices
end
