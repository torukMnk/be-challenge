require 'spec_helper'

RSpec.describe Client do
  EMAIL = 'guillermoq@test.com'
  PASSWORD = 'password'
  TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.ETUYUOkmfnWsWIvA8iBOkE2s1ZQ0V_zgnG_c4QRrhbg'

  describe '#login' do
    let(:client) { described_class.new(:post) }
    context '200 response' do
      it 'returns login token' do
        VCR.use_cassette("login") do
          response = client.request('/login',{ email: EMAIL, password: PASSWORD}, { Authorization: TOKEN} )
          expect(response.code).to eq(200)
          expect(response.parsed_response['token']).to eq(TOKEN)
        end
      end
    end
  end

  describe '#reports' do
    let(:client) { described_class.new(:get) }
    let(:reports) { reports_reponse }
    context '200 response' do
      it 'returns reports' do
        VCR.use_cassette("reports") do
          response = client.request('/reports', {}, { Authorization: TOKEN} )
          expect(response.code).to eq(200)
          expect(response[0]['report_id']).to eq(7426)
          expect(response[1]['report_id']).to eq(4738)
          expect(response[2]['report_id']).to eq(3745)
        end
      end
    end

    def reports_reponse
      [
        {
          "name"=>"Kamino Human Resources, LTD",
          "location"=>"Kamino",
          "currency"=>"Republic Credits",
          "symbol"=>"RCR",
          "report_id"=>7426,
          "format"=>"json",
          "referrence_id"=>"The id you submited to identify your transaction is under 'account', as 'referrence_id'"
        },
        {
          "name"=>"Mon Calamari Shipyards",
          "location"=>"Mon Cala",
          "currency"=>"Calamari Flan",
          "symbol"=>"CFL",
          "report_id"=>4738,
          "format"=>"csv",
          "referrence_id"=>"The id you submited to identify your transaction is as 'account_external_ref'",
          "note"=>"Value is not in full CFL"
        },
        {
          "name"=>"Creed Forge",
          "location"=>"REDACTED",
          "currency"=>"Republic Credits",
          "symbol"=>"RCR",
          "report_id"=>3745,
          "format"=>"xml",
          "referrence_id"=>"The id you submited to identify your transaction is as 'client_external_id'"
        }
      ]
    end
  end

  describe '#reports/:id' do
    let(:client) { described_class.new(:get) }

    context '200 response JSON format' do
      let(:json_attributes) { ["id", "created_at", "placed_at", "paid_at", "value", "status", "items", "delivery_notes", "account"] }
      it 'returns JSON reports' do
        VCR.use_cassette("reports/7426") do
          response = client.request('/reports/7426', {}, { Authorization: TOKEN} )
          expect(response.code).to eq(200)
          expect(response.first.keys).to eq(json_attributes)
        end
      end
    end

    context '200 response CSV format' do
      let(:csv_attributes) { ["id", "created_at", "placed_at", "paid_at", "value", "status", "order_details", "account_number", "account_external_ref", "account_name", "account_contact"] }
      it 'returns JSON reports' do
        VCR.use_cassette("reports/4738") do
          response = client.request('/reports/4738', {}, { Authorization: TOKEN} )
          expect(response.code).to eq(200)
          csv = CSV.parse(response.body)
          expect(csv.first).to eq(csv_attributes)
        end
      end
    end

    context '200 response XML format' do
      it 'returns JSON reports' do
        VCR.use_cassette("reports/3745") do
          response = client.request('/reports/3745', {}, { Authorization: TOKEN} )
          expect(response.code).to eq(200)
        end
      end
    end
  end
end
