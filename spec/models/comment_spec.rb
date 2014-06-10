require 'spec_helper'

describe Comment do
  it { should belong_to(:commentable) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:text) }
  it { should ensure_length_of(:text).is_at_least(20).is_at_most(600) }

let!(:question) { create(:question)}
let!(:answer) { create(:answer)}
let!(:comment) { create(:comment)}

  describe '#question' do
    context 'returns object question ' do
      it 'when class Question' do
        comment.commentable = question
        expect(comment.commentable).to equal question
      end

      it 'when class Answer' do
        comment.commentable = answer
        expect(comment.commentable).to equal answer
      end
    end
  end

end
