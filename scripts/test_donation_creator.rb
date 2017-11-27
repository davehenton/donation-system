# frozen_string_literal: true

require 'pry'
require_relative '../lib/donation_system/donation_data'
require_relative '../lib/donation_system/salesforce/donation_creator'
require_relative '../spec/donation_system/data_structs_for_tests'

module DonationSystem
  data = DonationData.new(VALID_REQUEST_DATA, VALID_PAYMENT_DATA)
  supporter = SupporterSObjectFake.new('0013D00000LBYutQAH')
  result = Salesforce::DonationCreator.execute(data, supporter)
  puts result
end
