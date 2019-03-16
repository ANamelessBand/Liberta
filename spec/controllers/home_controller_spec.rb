# frozen_string_literal: true

require "rails_helper"

RSpec.describe HomeController, type: :controller do
  subject { get :index }

  let (:news) { FactoryBot.create_list(:news, 10) }
  let (:prints) { FactoryBot.create_list(:print, 10) }

  describe "GET index" do
    it "assigns last_news" do
      allow(News).to receive_message_chain(:order, :last).and_return(news)

      subject

      expect(assigns(:last_news)).to eq news
    end

    it "assigns last_prints" do
      allow(Print).to receive_message_chain(:order, :last).and_return(prints)

      subject

      expect(assigns(:last_prints)).to eq prints
    end
  end
end
