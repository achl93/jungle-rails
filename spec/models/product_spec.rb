require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.new
  end
  describe 'Validations' do
    it 'should not be invalid with a proper category and all four fields set' do
      @product = @category.products.new(name: "Nice product", price_cents: 1, quantity: 1)
      expect(@product).to be_valid
    end
    it 'should not be valid without a name' do
      @product = @category.products.new(price_cents: 2, quantity: 2)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include('can\'t be blank')
    end
    it 'should not be valid without a price' do
      @product = @category.products.new(name: "Nicer product", quantity: 3)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price_cents]).to include('is not a number')
      expect(@product.errors.messages[:price]).to include('is not a number')
      expect(@product.errors.messages[:price]).to include('can\'t be blank')
    end
    it 'should not be valid without a quantity' do
      @product = @category.products.new(name: "Niceish product", price_cents: 4)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
    end
    it 'should not be valid without a category' do
      @product = Product.new(name: "Nicest product", quantity: 5, price: 5)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end
