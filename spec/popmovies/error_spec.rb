require 'spec_helper'

module Popmovies
  include Views
  describe Error do
    it { is_expected.to be_a_kind_of StandardError }
    it { is_expected.to respond_to(:handle) }
    describe "#handle" do
      pending "youpi"
    end
  end

  describe ConnectionError do
    it { is_expected.to be_a_kind_of Error }
    it { is_expected.to respond_to(:handle) }
  end

  describe RemoteError do
    it { is_expected.to be_a_kind_of Error }
    it { is_expected.to respond_to(:handle) }
  end
end
