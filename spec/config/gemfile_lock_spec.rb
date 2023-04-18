require 'rails_helper'

RSpec.describe "Gemfile" do
  describe "basic config" do
    subject { File.readlines('Gemfile.lock') }

    it 'includes linux platform' do
      # I want the linux platform to be present in the gemfile, because circleci will otherwise modify it adding this platform
      # This leads to a cache miss when pre-loading the env.
      # If this spec fails, try running `bundle lock --add-platform x86_64-linux`
      expect(subject.grep(/x86_64-linux/)).not_to be_empty
    end
  end
end
