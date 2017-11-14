# frozen_string_literal: true

require 'donation_system/thank_you_mailer'
require 'spec_helper'

module DonationSystem
  RSpec.describe ThankYouMailer do
    let(:email) { described_class.send_email('user@example.com', 'Firstname') }

    it 'requires a from field' do
      expect(email.from).not_to be(nil)
    end

    it 'sends an email to the receiver' do
      expect(email.to).to eq(['user@example.com'])
    end

    it 'sends a simple text email including the person name' do
      expect(email.body).to include('Firstname')
    end

    it 'has a subject' do
      expect(email.subject).not_to be(nil)
    end
  end
end