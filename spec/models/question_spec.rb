require 'spec_helper'

describe Question do
  it { should belong_to(:user) }
  it { should have_many(:votes) }
  it { should have_many(:favorites) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:attachments) }
  it { should have_many(:taggings) }
  it { should have_many(:tags).through(:taggings) }
  it { should accept_nested_attributes_for :attachments }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should ensure_length_of(:title).is_at_least(10).is_at_most(100) }
  it { should ensure_length_of(:body).is_at_least(50).is_at_most(600) }

  let(:questions) { create_list(:question, 5) }
  let(:question) { create(:question) }
  let(:tag1) { create(:tag, name: 'Ruby') }
  let(:tag2) { create(:tag, name: 'Rails') }
  let(:tag3) { create(:tag, name: 'Ajax') }

  context '::with_tag' do
    it 'returns array of questions objects' do
      questions.each do |q|
        q.tags << tag1
      end
      questions_tag = Question.with_tag('Ruby')

      expect(questions_tag).to match_array questions
    end
  end

  context '#tags_list' do
    it 'returns array of tag names' do
      question.tags << [tag1, tag2, tag3]
      list = question.tags_list

      expect(list).to match_array [ tag1.name, tag2.name, tag3.name, question.tag_names ]
    end
  end


  describe "#save_tags" do

    context "when tag_names've existed already" do
      it 'returns record with current name' do
        tag1
        new_question = create(:question, tag_names: 'Ruby')
        expect{ new_question.save_tags }.to_not  change(Tag, :count)
      end
    end
  end
end
