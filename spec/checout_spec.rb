require_relative '../lib/checkout'

RSpec.describe 'Test Price' do

  subject(:price) do
    items_in_basket.split(//).each { |item| checkout.scan(item) }
    checkout.total
  end

  let(:items_in_basket) {}
  let(:checkout) { Checkout.new(price_rules) }
  let(:price_rules) do
    {
        'A' => {
            unit_price: 50,
            special_price: {
                count: 3,
                price: 130
            }
        },
        'B' => {
            unit_price: 30,
            special_price: {
                count: 2,
                price: 45
            }
        },
        'C' => {
            unit_price: 20
        },
        'D' => {
            unit_price: 15
        }
    }
  end

  describe 'when basket is empty' do
    let(:items_in_basket) { '' }
    it { is_expected.to eq 0 }
  end

  describe 'when basket contains product A' do
    let(:items_in_basket) { 'A' }
    it { is_expected.to eq 50 }
  end

  describe 'when basket contains products A and B' do
    let(:items_in_basket) { 'AB' }
    it { is_expected.to eq 80 }
  end

  describe 'when basket contains 3 time product A' do
    let(:items_in_basket) { 'AAA' }
    it { is_expected.to eq 130 }
  end

  describe 'when basket contains 4 times product A' do
    let(:items_in_basket) { 'AAAA' }
    it { is_expected.to eq 180 }
  end

  describe 'when basket contains 2 times product DD' do
    let(:items_in_basket) { 'DD' }
    it { is_expected.to eq 30 }
  end
end
