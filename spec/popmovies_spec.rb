require 'spec_helper'

describe Popmovies do
  it 'has a version number' do
    expect(Popmovies::VERSION).not_to be_nil
  end
  describe "#start" do
    it "method present?" do
      expect(Popmovies).to respond_to(:start)
    end
  end
end
