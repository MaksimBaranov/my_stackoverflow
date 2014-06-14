require "spec_helper"

describe UserEmail do
  describe "verification_letter" do
    let(:mail) { UserEmail.verification_letter }

    it "renders the headers" do
      mail.subject.should eq("Verification letter")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
