require 'spec_helper'

describe Pricing do

  let(:pricing) { Pricing.new(unit_price,quantity_rules) }
  let(:unit_price) { 40 }
  let(:quantity_rules) { [
    [3,100],
    [7,250]
  ] }

  describe "#calculate" do
    subject { pricing.calculate quantity }
    context "zero quantity" do
      let(:quantity) { 0 }
      it { should == 0}
    end
    context "without quantity exceptions" do
      let(:quantity) { 2 }
      it { should ==  80 }
    end
    context "first quantity exceptions" do
      let(:quantity) { 3 }
      it { should ==  100 }
    end
    context "past first quantity exception" do
      let(:quantity) { 5 }
      it { should ==  180 }
    end
    context "at second quantity exception" do
      let(:quantity) { 7 }
      it { should ==  250 }
    end
    context "past second quantity exception" do
      let(:quantity) { 10 }
      it { should ==  350 }
    end
  end
end