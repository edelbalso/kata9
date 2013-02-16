require 'spec_helper'

describe CheckOut do

  let(:checkout) { CheckOut.new(rules) }
  let(:rules) { {
    'A' => { price: 25, quantity_pricings: [[6, 130]] },
    'B' => { price: 10, quantity_pricings: [[2,15],[5,35]] },
    'C' => 50,
    'D' => 12,
  } }

  describe "#scan" do
    subject { checkout.scan sku }

    let(:sku) { 'B' }

    it "should add the items to item array" do
      subject
      checkout.items.map(&:sku).should == [sku]
    end

    describe "error handling" do
      context "invalid sku" do
        let(:sku) { 'E' }
        it "should raise an error" do
          lambda { subject }.should raise_exception InvalidSkuError
        end
      end
    end
  end
end