require 'rails_helper'

RSpec.describe TestConfiguration, type: :model do

  $default_tags = %w(A B C D)
  $default_subjects = %w(1 2 3 4)

  $other_tags = %w(W X Y Z)
  $other_subjects = %w(6 7 8 9)

  $all_tags = $default_tags + $other_tags
  $all_subjects = $default_subjects + $other_subjects

  $default_other_options = {difficulty: 50, grade_level: 5}

  def new_test_config(number_of_questions: 100, difficulty: (1..100), grade_level: (1..12))
    TestConfiguration.create(number_of_questions: number_of_questions, min_difficulty: difficulty.min, max_difficulty: difficulty.max, min_grade_level: grade_level.min, max_grade_level: grade_level.max)
  end

  def tag_model(model, **tags)
    tags.each_pair do |name, list|
      model.instance_variable_set "@#{name.to_s.singularize}_list", ActsAsTaggableOn.default_parser.new(list).parse
    end
    model
  end

  before :each do
    3.times do
      new_both_question
      new_tag_question
      new_subject_question
      new_neither_question
    end
  end

  def new_question(subject_list: $other_subjects, tag_list: $other_tags, difficulty: $default_other_options[:difficulty], grade_level: $default_other_options[:grade_level])
    Question.create(subject_list: subject_list, tag_list: tag_list, difficulty: difficulty, grade_level: grade_level)
  end
  alias_method :new_neither_question, :new_question

  def new_both_question
    new_question subject_list: $default_subjects, tag_list: $default_tags
  end

  def new_subject_question
    new_question subject_list: $default_subjects
  end

  def new_tag_question
    new_question tag_list: $default_tags
  end

  describe "#tagged_questions" do

    def new_config(tags:, subjects:)
      $config = tag_model new_test_config, subjects: subjects, tags: tags
      $questions = $config.build_questions
      $tags = $questions.flat_map { |q| q.tag_list }.uniq
      $subjects = $questions.flat_map { |q| q.subject_list }.uniq
    end

    context "with no subjects or tags" do
      before { new_config tags: [], subjects: [] }

      it "returns all questions" do
        expect($questions).to match_array Question.all
      end

      it "returns questions with any tag" do
        expect($tags).to match_array $all_tags
      end

      it "returns questions with any subject" do
        expect($subjects).to match_array $all_subjects
      end
    end

    context "with tags but no subjects" do
      before { new_config tags: $default_tags, subjects: [] }

      it "returns questions with any subject" do
        expect($subjects).to match_array $all_subjects
      end

      it "returns questions with given tags" do
        expect($tags).to match_array $default_tags
      end
    end

    context "with subjects but no tags" do
      before { new_config tags: [], subjects: $default_subjects }

      it "returns questions with any tag" do
        expect($tags).to match_array $all_tags
      end

      it "returns questions with given subjects" do
        expect($subjects).to match_array $default_subjects
      end
    end

    context "with subjects and tags" do
      before { new_config tags: $default_tags, subjects: $default_subjects }

      it "returns questions with given tags" do
        expect($tags).to match_array $default_tags
      end

      it "returns questions with given subjects" do
        expect($subjects).to match_array $default_subjects
      end
    end
  end
end
