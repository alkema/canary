require 'spec_helper'

RSpec.describe Canary::Notifiers::SlackAttachment do
  include_context 'stub app names'

  let(:example_hash) { examples.first }
  let(:example) { Canary::Example.new(example_hash) }

  subject(:slack_attachment) { described_class.new(example) }

  subject(:attachment) do
    {
      pretext: pretext,
      text: text,
      fields: fields,
      color: color,
      mrkdwn_in: %w(text pretext)
    }
  end

  let(:pretext) { 'Failed _Canary_ spec for *google* on *https://google.com*' }

  let(:text) { '_*user signs in*_' }

  let(:color) { '#b20000' }

  let(:fields) do
    [
      {
        title: 'Source cluster',
        value: 'localhost',
        short: true
      },
      {
        title: 'Target cluster',
        value: 'production',
        short: true
      },
      {
        title: 'File path',
        value: example.file_path,
        short: false
      },
      {
        title: 'Exception',
        value: 'expected to find text "Pendingx" in "Bookings Pending 62 Waitlist 15"',
        short: false
      }
    ]
  end

  context 'failing example' do
    include_context 'failing output hash'

    describe '.call' do
      it 'returns a slack attachment hash' do
        expect(slack_attachment.call).to eq(attachment)
      end
    end

    describe '#pretext' do
      it 'renders pretext' do
        expect(slack_attachment.pretext).to eq(pretext)
      end
    end

    describe '#text' do
      it 'renders text' do
        expect(slack_attachment.text).to eq(text)
      end
    end

    describe '#color' do
      it 'determines color from the status' do
        expect(slack_attachment.color).to eq(color)
      end
    end

    describe '#fields' do
      it 'renders fields' do
        expect(slack_attachment.fields).to eq(fields)
      end
    end
  end
end
