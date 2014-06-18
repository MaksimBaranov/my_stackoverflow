require 'spec_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe "for quest" do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should be_able_to :read, Tag }
    it { should be_able_to :read, User }

    it { should_not be_able_to :manage, :all }
  end


  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Tag }

    it { should be_able_to :update, create(:question, user: user),  user_id: user.id }
    it { should_not be_able_to :update, create(:question, user: user1),  user_id: user.id }

   it { should be_able_to :update, create(:answer, user: user),  user_id: user.id }
   it { should_not be_able_to :update, create(:answer, user: user1),  user_id: user.id }

   it { should be_able_to :update, create(:comment, user: user),  user_id: user.id }
   it { should_not be_able_to :update, create(:comment, user: user1),  user_id: user.id }

   it { should be_able_to :destroy, create(:question, user: user),  user_id: user.id }
   it { should_not be_able_to :destroy, create(:question, user: user1),  user_id: user.id }

   it { should be_able_to :destroy, create(:answer, user: user),  user_id: user.id }
   it { should_not be_able_to :destroy, create(:answer, user: user1),  user_id: user.id }

   it { should be_able_to :destroy, create(:comment, user: user),  user_id: user.id }
   it { should_not be_able_to :destroy, create(:comment, user: user1),  user_id: user.id }

   it { should be_able_to :best, create(:answer, user: user1),  user_id: user.id }
   it { should_not be_able_to :best, create(:answer, user: user),  user_id: user.id }

   # it { should be_able_to :up, create(:vote, user_id: user1),  user_id: user.id }
   # it { should_not be_able_to :up, create(:vote, user: user),  user_id: user.id }

   # it { should be_able_to :down, create(:vote, user: user1),  user_id: user.id }
   # it { should_not be_able_to :down, create(:vote, user: user),  user_id: user.id }
  end
end
