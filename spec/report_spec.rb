require 'spec_helper'

RSpec.describe Report do
  describe '#login' do
    let(:report) { described_class }

    context '200 response' do
      it 'returns reports and details' do
        expect(Sidekiq::Worker.jobs.size).to eq(0)
        VCR.insert_cassette("login")
        VCR.use_cassette("reports") do
          VCR.insert_cassette("reports/7426")
          VCR.insert_cassette("reports/4738")
          VCR.insert_cassette("reports/3745")
          expect(report.fetch!).to eq(reports_fetch_response)
          expect(Sidekiq::Worker.jobs.size).to eq(47)
        end
        VCR.eject_cassette(name: 'reports')
        VCR.eject_cassette(name: 'reports')
        VCR.eject_cassette(name: 'reports')
      end

      def reports_fetch_response
        [{:id=>7426, :format=>"json", :currency=>"RCR"},
         {:id=>4738, :format=>"csv", :currency=>"CFL"},
         {:id=>3745, :format=>"xml", :currency=>"RCR"}]
      end
    end
  end
end
