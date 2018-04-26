class CartContain < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product, prefix: :product, allow_nil: true

  before_destroy :return_quantity
  after_save :update_grand_total

  def return_quantity
    product.update quantity: product.quantity + quantity unless order.accept?
  end

  private

  def update_grand_total
    order.update grand_total: order.grand_total + price * quantity
    product.update quantity: product.quantity - quantity
  end
end
