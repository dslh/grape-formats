require 'spec_helper'
require 'grape/formats/date_times'

describe Grape::Formats::DateTimes do
  let(:api) { Class.new(Grape::API) }

  def app
    api
  end

  DATE_TIME_INPUTS = {
    HttpDate: ['Sat, 03 Feb 2001 04:05:06 GMT'],
    Iso8601: %w(
      2001-02-03T04:05:06+07:00
      20010203T040506+0700
      2001-W05-6T04:05:06+07:00
    ),
    Jisx0301: %w(H13.02.03T04:05:06+07:00),
    JulianDay: %w(2451944),
    Rfc2822: ['Sat, 3 Feb 2001 04:05:06 +0700'],
    Rfc3339: %w(2001-02-03T04:05:06+07:00),
    Rfc822: ['Sat, 3 Feb 2001 04:05:06 +0700'],
    XmlSchema: %w(2001-02-03T04:05:06+07:00)
  }

  COERCION_EXPECTATION = Hash.new('DateTime.2001-02-03T04:05:06+07:00')
  # Special expectations for formats that don't support
  # full timestamp plus timezone.
  COERCION_EXPECTATION[:HttpDate] = 'DateTime.2001-02-03T04:05:06+00:00'
  COERCION_EXPECTATION[:JulianDay] = 'DateTime.2001-02-03T00:00:00+00:00'

  context 'timestamp coercion' do
    described_class.constants.each do |format_name|
      it "coerces from #{format_name}" do
        format = described_class.const_get format_name
        api.params do
          requires :time, type: format
        end
        api.get '/' do
          "#{params[:time].class}.#{params[:time]}"
        end

        DATE_TIME_INPUTS[format_name].each do |input|
          get '/', time: input
          expect(last_response.status).to eq(200)
          expect(last_response.body).to eq(COERCION_EXPECTATION[format_name])

          get '/', time: 'definitely not a timestamp'
          expect(last_response.status).to eq(400)
          expect(last_response.body).to eq('time is invalid')
        end
      end
    end
  end
end
