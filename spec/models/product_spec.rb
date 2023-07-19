require 'rails_helper'

RSpec.describe Product, type: :model do

  before do
    @category = Category.new(name: 'Flowers')
    @category.save
  end

  describe 'Validations' do

    it "should save a product successfully with all four fields set" do
      @product = Product.new(name: "rose", price: 75, quantity: 20, category: @category)
      @product.save
      expect(@product.errors.full_messages.length).to eql(0)
    end

    it "should have an error message if name is not set" do
      @product = Product.new(price: 75, quantity: 20, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should have an error message if price is not set" do
      @product = Product.new(name: "rose", quantity: 20, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should have an error message if quantity is not set" do
      @product = Product.new(name: "rose", price: 75, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should have an error message if category is not set" do
      @product = Product.new(name: "rose", price: 75, quantity: 20)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end