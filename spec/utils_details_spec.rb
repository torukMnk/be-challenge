require 'spec_helper'

RSpec.describe Utils::Details do
  describe '#Utils::Details' do
    context '200 response' do
      it 'returns reports details' do
        VCR.use_cassette("reports") do
          VCR.insert_cassette("reports/7426")
          details = Utils::Details.call(TOKEN, {:id=>7426, :format=>"json", :currency=>"RCR"})
          expect(details.first).to eq(details_reponse.first)
          expect(details.count).to eq(21)
          expect(Sidekiq::Worker.jobs.size).to eq(21)
        end
        VCR.eject_cassette(name: 'reports')
      end

      def details_reponse
        [
          {
            :intent_id=>"986f81216a9e7a9d16cace11e8fecc15",
            :value_in_cents=>7450495,
            :status=>"PAID",
            :external_id=>"a3715bed-5d49-475d-91e9-962c31b374e2",
            :currency=>"RCR",
            :paid_at=>"2022-02-20 19:09:31 -0500"
          }
        ]
      end
    end
  end
end
