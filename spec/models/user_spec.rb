# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many :recommendations }
  it { is_expected.to have_many :notifications }
  it { is_expected.to have_many :wishlists }
  it { is_expected.to have_many :loans }
end