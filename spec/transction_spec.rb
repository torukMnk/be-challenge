ENV['APP_ENV'] = 'test'

require './models/transaction'
require 'rspec'

RSpec.describe 'Transaction' do
  after(:all) { Transaction.destroy_all}

  it "is valid" do
    transaction = Transaction.new transaction_params
    expect(transaction.valid?).to be true
  end

  def transaction_params(attributes = {})
  	{
  	}.merge(attributes)
  end
end


    # t.string :intent_id, null: false
    # t.string :external_id, index: { unique: true }
    # t.integer :value_in_cents, null: false
    # t.string :currency, null: false
    # t.string :status, null: false
