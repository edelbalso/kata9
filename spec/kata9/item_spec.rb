require 'spec_helper'

describe Item do

  subject { Item.new(sku) }
  let(:sku) { "A" }

  describe "#new" do
    its(:quantity) { should == 0 }
  end
  describe "#increment" do
    before { 8.times{ subject.increment }}
    its(:quantity) { should == 8 }
  end
end