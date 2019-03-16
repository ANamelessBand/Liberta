# frozen_string_literal: true

require "rails_helper"

RSpec.describe Print, type: :model do
  it { is_expected.to have_many :copies }
  it { is_expected.to have_many :recommendations }
  it { is_expected.to have_many :wishlists }

  it { is_expected.to belong_to :publisher }

  it { is_expected.to have_and_belong_to_many :tags }
  it { is_expected.to have_and_belong_to_many :authors }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :language }
  it { is_expected.to validate_presence_of :publisher_id }
end
