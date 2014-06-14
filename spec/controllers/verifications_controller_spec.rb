require 'spec_helper'

describe VerificationsController do

  describe "GET 'take'" do
    it "returns http success" do
      get 'take'
      response.should be_success
    end
  end

  describe "GET 'verify'" do
    it "returns http success" do
      get 'verify'
      response.should be_success
    end
  end

end
