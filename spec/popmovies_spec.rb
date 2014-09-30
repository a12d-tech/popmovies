require 'spec_helper'

describe Popmovies do
  it { expect(Popmovies).to respond_to(:start) }

  it 'has a version number' do
    expect(Popmovies::VERSION).not_to be_nil
  end
end
