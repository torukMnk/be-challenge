require 'spec_helper'

RSpec.describe TransactionJob do
  describe '#TransactionJob' do
    after(:each) { Transaction.destroy_all}

    context 'QUEUE' do
      it 'creates a transaction' do
        Sidekiq::Testing.inline! do
          TransactionJob.perform_async(transaction_success)
          expect(Transaction.count).to eq(1)
        end
      end

      it 'update transaction PARTIALLY_REFUNDED rule' do
        Sidekiq::Testing.inline! do
          duplicated_transactions.each do |data|
            TransactionJob.perform_async(data)
          end
        end
        expect(Transaction.count).to eq(1)
        expect(Transaction.first.status).to eq('PARTIALLY_REFUNDED')
      end

      def transaction_success
        {:intent_id=>"7bfc5f67c56055ce520382163d4ef2dc",
         :value_in_cents=>5055805,
         :status=>"PAID",
         :external_id=>"4a1c808f-7562-47ae-bb60-d8dc765ef105",
         :currency=>"RCR",
         :paid_at=>"2022-02-20 19:09:31 -0500"
        }
      end

      def duplicated_transactions
        [
         {:intent_id=>"6f9fac12b035757edd1c0983da525fed",
          :value_in_cents=>7927282,
          :status=>"PAID",
          :external_id=>"a98b535d-afa1-44ef-91fe-b1e8bc09de53",
          :currency=>"RCR",
          :paid_at=>"2022-02-20 19:09:31 -0500"
         },
         {
           :intent_id=>"6f9fac12b035757edd1c0983da525fed",
           :value_in_cents=>4386451,
           :status=>"PARTIALLY_REFUNDED",
           :external_id=>"a98b535d-afa1-44ef-91fe-b1e8bc09de53",
           :currency=>"RCR",
           :paid_at=>"2022-02-20 19:09:31 -0500"
         }
        ]
      end
    end
  end
end
