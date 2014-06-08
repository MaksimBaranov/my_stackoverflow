class AddAnswersCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :answers_count, :integer, :default => 0

    Question.reset_column_information
    Question.all.each do |p|
      Question.update_counters p.id, :answers_count => p.answers.length
    end
  end
end
