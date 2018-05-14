class CartContain < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product, prefix: :product, allow_nil: true
  acts_as_paranoid
  before_destroy :return_quantity
  after_save :update_grand_total

  def return_quantity
    product.update quantity: product.quantity + quantity if order.reject? && product.present?
  end

  private

  def update_grand_total
    order.update grand_total: order.grand_total + price * quantity
    product.update quantity: product.quantity - quantity
  end
end
