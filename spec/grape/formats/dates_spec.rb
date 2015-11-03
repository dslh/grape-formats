require 'spec_helper'
require 'grape/formats/dates'

describe Grape::Formats::Dates do
  let(:api) { Class.new(Grape::API) }

  def app
    api
  end

  DATE_INPUTS = {
    HttpDate: ['Sat, 03 Feb 2001 00:00:00 GMT'],
    Iso8601: %w(2001-02-03 20010203 2001-W05-6),
    Jisx0301: %w(H13.02.03),
    JulianDay: %w(2451944),
    Rfc2822: ['Sat, 3 Feb 2001 00:00:00 +0000'],
    Rfc3339: %w(2001-02-03T04:05:06+07:00),
    Rfc822: ['Sat, 3 Feb 2001 00:00:00 +0000'],
    XmlSchema: %w(2001-02-03)
  }

  context 'date coercion' do
    described_class.constants.each do |format_name|
      it "coerces from #{format_name}" do
        format = described_class.const_get format_name
        api.params do
          requires :date, type: format
        end
        api.get '/' do
          "#{params[:date].class}.#{params[:date]}"
        end

        DATE_INPUTS[format_name].each do |input|
          get '/', date: input
          expect(last_response.status).to eq(200)
          expect(last_response.body).to eq('Date.2001-02-03')

          get '/', date: 'definitely not a date'
          expect(last_response.status).to eq(400)
          expect(last_response.body).to eq('date is invalid')
        end
      end
    end
  end
end
