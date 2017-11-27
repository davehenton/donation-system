# frozen_string_literal: true

require 'pry'
require_relative '../lib/donation_system/payment.rb'

RawRequestData = Struct.new(:amount, :currency, :giftaid, :token,
                            :name, :email,
                            :address, :city, :state, :zip, :country)

VALID_REQUEST_DATA = RawRequestData.new(
  '12.0', 'gbp', true, ARGV[0], 'Firstname Lastname',
  'user@example.com', 'Address', 'City', 'State', 'Z1PC0D3', 'Country'
).freeze

puts DonationSystem::Payment.attempt(VALID_REQUEST_DATA)
